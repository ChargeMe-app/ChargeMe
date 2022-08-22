import 'dart:async';

import 'package:chargeme/components/helpers/periodic_timer.dart';
import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/main.dart';
import 'package:chargeme/view/login/enter_SMS_view.dart';
import 'package:chargeme/view/login/grouped_text_field.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterView();
}

class _RegisterView extends State<RegisterView> {
  String validationText = "";
  late GroupedTextFieldManager manager = GroupedTextFieldManager(
      format: "(***)***-**-**", onEndEditing: (str) => setValidationText(str), onChanged: (str) => setState(() {}));

  bool get freeze => PeriodicTimer.shared.remainingTime != 0;

  @override
  void initState() {
    super.initState();
    PeriodicTimer.shared.connect(onTick: () {
      setState(() {});
    }, onLastTick: () {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    PeriodicTimer.shared.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    final timeStr = PeriodicTimer.shared.remainingTimeString;
    return Scaffold(
        appBar: AppBar(title: const Text("Register"), backgroundColor: ColorPallete.violetBlue),
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Text(
                "Enter your phone number",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorPallete.violetBlue),
              )),
          Row(children: [
            const Spacer(),
            text("+7"),
            const SizedBox(width: 10),
            GroupedTextField(manager: manager),
            const Spacer()
          ]),
          Text(validationText),
          const Spacer(),
          PeriodicTimer.shared.remainingTime == 0
              ? Container()
              : Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    "Resend code available in $timeStr",
                    style: TextStyle(color: Colors.amber, fontSize: 14),
                  )),
          Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
              child: SimpleButton(
                  color: validate(manager.getText()) && !freeze ? ColorPallete.violetBlue : Colors.grey,
                  text: "Get SMS code",
                  onPressed: () {
                    if (validate(manager.getText()) && !freeze) {
                      setState(() {});

                      PeriodicTimer.shared.run(
                        duration: Duration(seconds: 300),
                        onTick: () {
                          setState(() {});
                        },
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EnterSMSView(),
                        ),
                      );
                    }
                  }))
        ]));
  }

  Widget text(String data) {
    return Text(data, style: TextStyle(fontSize: 26));
  }

  bool validate(String str) {
    return str.length == 10;
  }

  void setValidationText(String str) {
    setState(() {
      validationText = validate(str) ? "Nice" : "Enter valid phone number";
    });
  }
}

class SimpleButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function onPressed;

  const SimpleButton({required this.color, required this.text, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          primary: color,
          minimumSize: const Size.fromHeight(50),
        ),
        onPressed: () => onPressed(),
        child: Text(text, style: TextStyle(fontSize: 16)));
  }
}
