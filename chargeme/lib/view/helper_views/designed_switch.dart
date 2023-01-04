import 'package:chargeme/extensions/color_pallete.dart';
import 'package:flutter/cupertino.dart';

class DesignedSwitch extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;

  const DesignedSwitch({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(activeColor: ColorPallete.violetBlue, value: value, onChanged: onChanged);
  }
}
