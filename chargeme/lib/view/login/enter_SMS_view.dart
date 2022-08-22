import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/view/login/profile_view.dart';
import 'package:chargeme/view/login/grouped_text_field.dart';
import 'package:chargeme/view/login/phone_register_view.dart';
import 'package:flutter/material.dart';

class EnterSMSView extends StatefulWidget {
  const EnterSMSView({super.key});

  @override
  State<EnterSMSView> createState() => _EnterSMSView();
}

class _EnterSMSView extends State<EnterSMSView> {
  late GroupedTextFieldManager manager =
      GroupedTextFieldManager(format: "****", onEndEditing: (str) {}, onChanged: (str) => setState(() {}));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Enter SMS code"), backgroundColor: ColorPallete.violetBlue),
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Text(
                "Enter code from SMS",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorPallete.violetBlue),
              )),
          Row(children: [const Spacer(), GroupedTextField(manager: manager), const Spacer()]),
          const Spacer(),
          Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
              child: SimpleButton(
                  color: validate(manager.getText()) ? ColorPallete.violetBlue : Colors.grey,
                  text: "Go to profile",
                  onPressed: () {
                    if (validate(manager.getText())) {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ProfileView(),
                      //   ),
                      // );
                    }
                  }))
        ]));
  }

  bool validate(String str) {
    return str == "8888";
  }
}
