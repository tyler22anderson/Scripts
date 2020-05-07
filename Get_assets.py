import requests
import json
import csv

#Variables for this plugin
api_base_url = 'https://example.freshservice.com/api/'
api_token = "API KEY"

r = requests.get('https://example.freshservice.com/api/assets?per_page=100', auth=(api_token,'x'))

data = json.loads(r.content)

with open('/home/tanderson/Scripts/serial_numbers.csv', 'rb') as csvfile:
    s = csv.reader(csvfile)
    for row in s:
        print ', '.join(row)
        for serial in row:
            r = requests.get("https://example.freshservice.com/cmdb/items/list.json?field=serial_number&q=" + serial , auth=(api_token,'x'))

            data = json.loads(r.content)

            print(data['config_items'][0]['user_id'])















#for row in data2["serial number"]:

#    print(', ').join(row)
#    for
#    print(asset["asset_tag"])
#    print(asset["user_id"])

#        for user in data["user_id"]

#                print(id["first_name"] + " " + agent["last_name"])
