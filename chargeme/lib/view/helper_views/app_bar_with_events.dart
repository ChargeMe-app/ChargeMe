import 'package:chargeme/extensions/color_pallete.dart';
import 'package:flutter/material.dart';

extension AppBarWithEvents on AppBar {
  static AppBar create(
      {required BuildContext context, Widget? title, Function? onBackButtonPressed, List<Widget>? actions}) {
    return AppBar(
        title: title,
        backgroundColor: ColorPallete.violetBlue,
        leading: IconButton(
            icon: const Icon(Icons.chevron_left_rounded),
            iconSize: 40,
            onPressed: () {
              if (onBackButtonPressed != null) onBackButtonPressed();
              Navigator.pop(context, true);
            }),
        actions: actions);
  }
}
