import json

l10n_file = open('l10n.dart', mode="w")
en_file = open('../l10n/app_en.arb', mode="r")
ru_file = open('../l10n/app_ru.arb', mode="r")

json_en = json.loads(en_file.read())
json_ru = json.loads(ru_file.read())

assert json_en.keys() == json_ru.keys(), "The keys are inconsistent"

l10n_file.write('''import 'package:get/get.dart';

enum L10n {\n''')

sorted_keys = sorted(json_en.keys())
for key in sorted_keys:
    l10n_file.write(f"  {key},\n")

l10n_file.write("}\n\n")

l10n_file.write('''extension GetString on L10n {
  String get str {
    if (Get.deviceLocale?.languageCode == "ru") {
      switch (this) {\n''')

for key in sorted_keys:
    l10n_file.write(f"        case L10n.{key}:\n")
    l10n_file.write(f"          return \"{json_ru[key]}\";\n")

l10n_file.write('''      }
    } else {
      switch (this) {\n''')

for key in sorted_keys:
    l10n_file.write(f"        case L10n.{key}:\n")
    l10n_file.write(f"          return \"{json_en[key]}\";\n")

l10n_file.write('''      }
    }
  }
}''')

en_file.close()
ru_file.close()
l10n_file.close()

# extension GetString on L10n {
#   String get str {
#     if (Intl.getCurrentLocale().startsWith("ru")) {
#       switch (this) {

    #   }
    # } else {
    #   switch (this) {

#       }
#     }
#   }
# }
