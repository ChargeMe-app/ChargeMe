import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/model/charging_place/charging_place.dart';
import 'package:flutter/material.dart';

class CheckInOptionsView extends StatelessWidget {
  CheckInOptionsView({this.place});

  ChargingPlace? place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Check in"), backgroundColor: ColorPallete.violetBlue), body: Text("Check in"));
  }
}
