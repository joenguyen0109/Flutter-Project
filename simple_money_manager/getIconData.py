import os
import json
path =  os.path.dirname(os.path.realpath(__file__)) + '/icon'
print(os.listdir(path))

data = {}




for folder in os.listdir(path):
    list = [] 
    for icon in os.listdir(os.path.join(path,folder)):
        list.append('icon' + '/' + folder + '/' + icon)
    data[folder] = list

with open('icon.json', 'w') as fp:
    json.dump(data, fp)


print(json.dumps(data))
