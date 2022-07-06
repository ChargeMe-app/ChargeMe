import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/view/map/map.dart';
import 'package:flutter/material.dart';

class ChangeStationLocationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit location'),
        backgroundColor: ColorPallete.violetBlue,
      ),
      body: GMap(),
    );
  }
}
