import 'package:chargeme/extensions/color_pallete.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  String text;

  TitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(color: ColorPallete.violetBlue, fontWeight: FontWeight.bold, fontSize: 18));
  }
}
