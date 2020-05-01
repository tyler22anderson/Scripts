# basics that we import for every plugin
import re
from slackbot.bot import respond_to
from slackbot.bot import listen_to
import logging
import rutils
logger = logging.getLogger(__name__)
import rdb

#Specific to this plugin
import requests
import json

#Variables for this plugin
domain = "tns"
password = "x"
fs_status = {}   # Lets build a dict of our status codes
fs_status[2] = "Open"
fs_status[3] = "Pending"
fs_status[4] = "Resolved"
fs_status[5] = "Closed"



def fs_group_lookup(url, group_dict):
    '''Takes a URL and a dictionary of groups.  Will insert into the dictionary
    and recurse on itself if there is a next link in the headers of the response'''
    r = requests.get(url, auth = (rutils.retrieve_api_key("api_freshservice_admin"), password))
    if r.status_code == 200:
        group_list = r.json()['groups']
        for group in group_list:
            group_dict[group['id']] = group['name']
            try:
                if r.headers['link']:
                    link = r.headers['link']
                    regex = r"https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)"
                    match = re.search(regex, link)
                    if match:
                        url = match.group()
                        fs_group_lookup(url, group_dict)
            except KeyError:
                pass
    else:
        return None

def rdb_group_cache_check(group_id=None):
    '''If run with no parameters, it will check to see if the cache is still present in the database.  If it is,
    it will pull from the cache to populate the local dictionary of groups.  If it is not, it will run a function to
    pull in the groups again, populate the cache, and return the info to populate the local dict.  If you pass it the
    ID of a group, it will attempt to retrieve the name from the cache.  If the name is not in the cache, it will
    refresh the cache, and then return the name.'''
    #init DB?
    db = rdb.Database()
    if db.get_cacheditem("fsgroups"):
        group_dict = json.loads(db.get_cacheditem("fsgroups"))
        if group_id:
            try:
                group_name = group_dict[group_id]
                if group_name:
                    return group_name
            except KeyError:
                group_dict = {}
                fs_group_lookup("https://tns.freshservice.com/api/v2/groups/", group_dict)
                db.set_cacheditem("fsgroups", json.dumps(group_dict), ttl=86400)
                group_name = group_dict[group_id]
                return group_name
    else:
        group_dict = {}
        fs_group_lookup("https://tns.freshservice.com/api/v2/groups/", group_dict)
        db.set_cacheditem("fsgroups", json.dumps(group_dict), ttl=86400)
        return group_dict

#Populate the fs_queue dictionary.
fs_queue = rdb_group_cache_check()


def fs_agent_name_lookup(id):
#   r = requests.get("https://"+ domain +".freshservice.com/api/v2/tickets/" + ticket + "?include=requester", auth = (api_key, password))
    r = requests.get("https://"+ domain +".freshservice.com/users/"+str(id)+".json", auth = (rutils.retrieve_api_key("api_freshservice_admin"), password))
    if r.status_code ==200:
        agent = json.loads(r.content.decode('utf-8'))
        return agent['agent']['user']['name']
    else:
        return id


#@respond_to('FS (.*)\?', re.IGNORECASE)
@listen_to('#(\d+)')
@listen_to('INC-(\d+)', re.IGNORECASE)
@listen_to('ticket(\d+)', re.IGNORECASE)
@listen_to('ticket (\d+)', re.IGNORECASE)
@listen_to('https:\/\/tns\.freshservice\.com\/helpdesk\/tickets\/(\d+)')
# Also work when recieved via DM
@respond_to('#(\d+)')
@respond_to('INC-(\d+)', re.IGNORECASE)
@respond_to('ticket(\d+)', re.IGNORECASE)
@respond_to('ticket (\d+)', re.IGNORECASE)
@respond_to('https:\/\/tns\.freshservice\.com\/helpdesk\/tickets\/(\d+)')
def fs_ticket_lookup(message, ticket):
    logger.info("I think I saw a Freshservice Ticket Number: " + ticket)
    bFound = False
    # Lets do a regular lookup first.  (API creds limited to normal user role)
    r = requests.get("https://"+ domain +".freshservice.com/api/v2/tickets/" + ticket + "?include=requester", auth = (rutils.retrieve_api_key("api_freshservice"), password))
    if r.status_code ==200:
        response = json.loads(r.content.decode('utf-8'))
        subject = response['ticket']['subject']
        status = fs_status[response['ticket']['status']]
        requester = response['ticket']['requester']['name']
        try:
            group = fs_queue[response['ticket']['group_id']]
        except (KeyError, TypeError):
            group = rdb_group_cache_check(group_id=response['ticket']['group_id'])
        assignee = fs_agent_name_lookup(response['ticket']['responder_id'])
        bFound = True
        message.send_webapi('https://tns.freshservice.com/helpdesk/tickets/' + ticket, attachments=[{
            'fallback': 'FreshService Ticket',
            'fields': [
                {
                'title': subject,
                'value': "Requester: " + requester,
                'short': False
                },
                {
                        'title': 'In Queue',
                        'value': group,
                        'short': True
                },
                {
                        'title': 'Assigned To',
                        'value': assignee,
                        'short': True
                },
                {
                        'title': 'Status',
                        'value': status,
                        'short': True
                }
            ]
           }])
    else:
    # Regular user couldn't find a ticket, so lets try again with an admin api_key
        r = requests.get("https://"+ domain +".freshservice.com/api/v2/tickets/" + ticket + "?include=requester", auth = (rutils.retrieve_api_key("api_freshservice_admin"), password))
        if r.status_code ==200:
            response = json.loads(r.content.decode('utf-8'))
            status = fs_status[response['ticket']['status']]
            requester = response['ticket']['requester']['name']
            try:
                group = fs_queue[response['ticket']['group_id']]
            except (KeyError, TypeError):
                group = rdb_group_cache_check(group_id=response['ticket']['group_id'])
            assignee = fs_agent_name_lookup(response['ticket']['responder_id'])
            bFound = True
            message.send_webapi('https://tns.freshservice.com/helpdesk/tickets/' + ticket, attachments=[{
                    'fallback': 'FreshService Ticket',
                    'fields': [
                        {
                        'title': "[Ticket " + ticket + "]",
                        'value': "Requester: " + requester,
                        'short': False
                        },
                        {
                                'title': 'In Queue',
                                'value': group,
                                'short': True
                        },
                        {
                                'title': 'Assigned To',
                                'value': assignee,
                                'short': True
                        },
                        {
                                'title': 'Status',
                                'value': status,
                                'short': True
                        }
                    ]
            }])
    if bFound == False:
        logger.info(ticket + " was not a valid FS ticket")
