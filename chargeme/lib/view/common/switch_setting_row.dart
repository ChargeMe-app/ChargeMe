import 'package:chargeme/extensions/color_pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchSettingRow extends StatelessWidget {
  String title;
  String? iconPath;
  bool value;
  Function(bool) onChanged;

  SwitchSettingRow({required this.title, required this.value, required this.onChanged, this.iconPath});

  @override
  Widget build(BuildContext context) {
    if (iconPath != null) {
      return ListTile(
          minLeadingWidth: 32,
          leading: SizedBox(width: 32, child: Image.asset(iconPath!)),
          title: Text(title),
          trailing: CupertinoSwitch(activeColor: ColorPallete.violetBlue, value: value, onChanged: onChanged));
    }
    // When leading parameter is present, the title always has offset
    return ListTile(
        title: Text(title),
        trailing: CupertinoSwitch(activeColor: ColorPallete.violetBlue, value: value, onChanged: onChanged));
  }
}
