import requests
import json

#Variables for this plugin
api_base_url = 'https://tns.freshservice.com/api/v2/'
api_token = "y6qUoFNRltXmNF61SD"

r = requests.get('https://tns.freshservice.com/api/v2/agents?per_page=100', auth=(api_token,'x'))

data = json.loads(r.content)

for agent in data["agents"]:
	print(agent["id"])
	print(agent["first_name"] + " " + agent["last_name"])
	print(agent["email"])



while r.headers.get('link'):
	next_url = r.links['next']['url']
	r = requests.get(next_url, auth=(api_token,'x'))
	
	data = json.loads(r.content)
	
	for agent in data["agents"]:
		print(agent["id"])
		print(agent["first_name"] + " " + agent["last_name"])
		print(agent["email"])



#print(data["agents"][0]["id"])
#print(data["agents"][0]["first_name"])
#print(data["agents"][0]["last_name"])
#print(data["agents"][0]["email"])

