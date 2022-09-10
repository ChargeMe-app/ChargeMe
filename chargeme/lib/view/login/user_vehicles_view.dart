import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/view/login/choose_vehicle_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserVehiclesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Choose vehicle"), backgroundColor: ColorPallete.violetBlue),
        body: Consumer<ChooseVehicleViewModel>(builder: (context, chooseVehicleVM, child) => Text("hello")));
  }
}
