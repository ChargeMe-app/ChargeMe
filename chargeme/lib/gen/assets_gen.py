import os

def getPathFromAssets(full_path: str):
    return full_path.split("/assets")[-1]

SUPPORTED_FORMATS = ["png", "jpeg", "svg"]
variable_to_path = {}

f = open('assets.dart', mode="w")
f.write("enum Asset {\n")

currentDir = os.getcwd()
assetsDir = "/".join(currentDir.split("/")[:-2]) + "/assets"
os.chdir(assetsDir)

# print(os.getcwd())
# print(os.listdir())

for roots, dirs, files in os.walk(assetsDir):
    for filename in files:
        file_components = filename.split(".")
        file_format = file_components[-1]
        if file_format in SUPPORTED_FORMATS:
            if file_components[0] in variable_to_path:
                assert(f"{file_components[0]} already exists")

            variable_to_path[file_components[0]] = f"assets{getPathFromAssets(roots)}/{filename}"

# print(variable_to_path)
sortedKeys = sorted(variable_to_path.keys())

for key in sortedKeys:
    f.write(f"  {key},\n")

f.write("}\n")

f.write('''
extension AssetPath on Asset {
  String get path {
    switch (this) {
''')

for key in sortedKeys:
    f.write(f"      case Asset.{key}:\n")
    f.write(f"        return \"{variable_to_path[key]}\";\n")

f.write("    }\n")
f.write("  }\n")
f.write("}\n")
