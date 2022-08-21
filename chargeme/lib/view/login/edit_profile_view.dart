import 'package:chargeme/extensions/color_pallete.dart';
import 'package:flutter/material.dart';

class EditProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Your profile"), backgroundColor: ColorPallete.violetBlue),
        body: Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Center(
                child: Column(children: [
              Container(height: 64, child: Image.asset("assets/icons/plugs/commando3pin.png")),
              const SizedBox(height: 12),
              titleText("Phone number"),
              TextFormField(
                  initialValue: "+79635151412",
                  style: TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                      fillColor: ColorPallete.violetBlue,
                      disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorPallete.violetBlue))),
                  enabled: false)
            ]))));
  }

  Widget titleText(String str) {
    return Text(str, style: TextStyle(color: ColorPallete.violetBlue, fontSize: 18, fontWeight: FontWeight.bold));
  }
}
