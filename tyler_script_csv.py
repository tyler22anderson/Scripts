import json
import sys
import csv
import requests

# Variables for this plugin
api_base_url = 'https://example.freshservice.com/api/'
api_token = "API"

with open('/home/tanderson/Scripts/serial_numbers.csv', 'r') as csvfile:
    serials = None
    for row in csvfile:
        serials = [row.split()[0] for row in csvfile if row != "Serial Number"]
    if serials:
        print("Found {} serial numbers.".format(len(serials)))
        serial_dict = {}
        for serial in serials:
            r = requests.get("https://example.freshservice.com/cmdb/items/list.json?field=serial_number&q=s" + serial,
                             auth=(api_token, 'x'))
            if r.status_code == 200:
                data = r.json()
                if 'config_items' in data and data['config_items']:
                    serial_dict[serial] = {"user_id": data['config_items'][0]['user_id'],
                                           "used_by": data['config_items'][0]['used_by'],
                                           "asset_tag": data['config_items'][0]['asset_tag']}
            elif r.content == b'You have exceeded the limit of requests per hour':
                sys.exit("You have exceeded the limit of requests per hour.")
            else:
                sys.exit(r.content)
        if serial_dict:
            with open('/home/tanderson/Scripts/serial_results_test.csv', 'w') as csv_file:
                fieldnames = ['serial', 'user_id', 'used_by', 'asset_tag']
                writer = csv.DictWriter(csv_file, fieldnames=fieldnames)
                writer.writeheader()
                writer.writerow(serial_dict)


                #outfile.write(json.dumps(serial_dict, indent=4))
