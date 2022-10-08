import json
import os
import re


result = {}
empty = {}

output = open('app_en.arb', mode="w")
output_ru = open('app_ru.arb', mode="w")

currentDir = os.getcwd()
viewsDir = "/".join(currentDir.split("/")[:-1]) + "/view"
os.chdir(viewsDir)

for roots, dirs, files in os.walk(viewsDir):
    for filename in files:
        with open(roots + "/" + filename, mode="r", encoding="ISO-8859-1") as f:
            content = f.read()
            matches = re.findall(r'"[a-zA-Z\s]+"', content)
            for match in matches:
                string = match[1:-1]
                key = string[0].lower() + "".join(string.title().split())[1:]
                result[key] = string
                empty[key] = ""

output.write(json.dumps(result, indent=4))
output_ru.write(json.dumps(empty, indent=4))

output.close()
output_ru.close()

