import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/view/helper_views/svg_colored_icon.dart';
import 'package:flutter/material.dart';

class ControlButtonsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          ControlWithTitle("assets/icons/common/star.svg", "В избранное".toUpperCase()),
          Container(width: 1, color: ColorPallete.violetBlue),
          ControlWithTitle("assets/icons/common/addPhoto.svg", "Добавить фото".toUpperCase()),
          Container(width: 1, color: ColorPallete.violetBlue),
          ControlWithTitle("assets/icons/common/directionRight.svg", "Маршрут".toUpperCase()),
          Container(width: 1, color: ColorPallete.violetBlue),
          ControlWithTitle("assets/icons/common/settings.svg", "Изменить".toUpperCase()),
        ]));
  }

  Widget ControlWithTitle(String assetPath, String title) {
    return Container(
        width: 96,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgColoredIcon(assetPath: assetPath, color: ColorPallete.violetBlue, height: 52),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: ColorPallete.violetBlue, fontSize: 10),
          )
        ]));
  }
}
