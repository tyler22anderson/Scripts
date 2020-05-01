import requests
import json
import csv
import json
​
# Variables for this plugin
api_base_url = 'https://tns.freshservice.com/api/'
api_token = "CdiOuyCc2hhqNS69w0J4"
​
with open('/home/tanderson/Scripts/serial_numbers.csv', 'r') as csvfile:
    serials = None
    for row in csvfile:
        serials = [row.split()[0] for row in csvfile if row != "Serial Number"]
    if serials:
        print(f"Found {len(serials)} serial numbers.")
        serial_dict = {}
        for serial in serials:
            r = requests.get("https://tns.freshservice.com/cmdb/items/list.json?field=serial_number&q=s" + serial, auth=(api_token, 'x'))
            if r.status_code == 200:
                data = r.json()
                if 'config_items' in data and data['config_items']:
                    serial_dict[serial] = {"user_id": data['config_items'][0]['user_id'], "used_by": data['config_items'][0]['used_by']}
            elif 'You have exceeded the limit of requests per hour' in r.content:
                print("You have exceeded the limit of requests per hour.")
            else:
                print(r.content)
        if serial_dict:
            print(json.dumps(serial_dict, indent=4))
