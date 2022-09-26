import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/gen/assets.dart';
import 'package:chargeme/model/vehicle/vehicle_type.dart';
import 'package:chargeme/extensions/string_extensions.dart';
import 'package:chargeme/view/helper_views/app_bar_with_events.dart';
import 'package:chargeme/view_model/choose_vehicle_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ChooseVehicleView extends StatelessWidget {
  final Duration animationDuration = const Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChooseVehicleViewModel>(
        builder: (context, chooseVehicleVM, child) => Scaffold(
            appBar: AppBarWithEvents.create(
                context: context,
                title: const Text("Choose vehicle"),
                onBackButtonPressed: () {
                  chooseVehicleVM.setChosenVehicleType();
                }),
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Column(
                        children: List.generate(Manufacturer.values.length, (i) {
                      Manufacturer manufacturer = Manufacturer.values[i];
                      bool isSelected = chooseVehicleVM.shownManufacturerIndex == i;
                      return Column(children: [
                        InkWell(
                            onTap: () {
                              chooseVehicleVM.shownManufacturerIndex =
                                  chooseVehicleVM.shownManufacturerIndex == i ? null : i;
                            },
                            child: Padding(
                                padding: EdgeInsets.all(14),
                                child: Row(children: [
                                  Text(manufacturer.name.capitalize,
                                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                                  const Spacer(),
                                  AnimatedRotation(
                                      turns: isSelected ? chooseVehicleVM.rotation : 0,
                                      duration: animationDuration,
                                      child: SvgPicture.asset(Asset.chevronDown.path))
                                ]))),
                        Container(color: Colors.black, height: 1),
                        AnimatedSize(
                            duration: animationDuration,
                            curve: Curves.easeInOutExpo,
                            child: Container(
                                height: isSelected ? null : 0,
                                child: Column(
                                    children: List.generate(VehicleType.values.length, (i) {
                                  final VehicleType vehicleType = VehicleType.values[i];
                                  bool isVehicleChosen = vehicleType == chooseVehicleVM.vehicleTypeToChoose;
                                  if (vehicleType.manufacturer == manufacturer) {
                                    return Padding(
                                        padding: EdgeInsets.fromLTRB(32, 8, 8, 8),
                                        child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () {
                                              chooseVehicleVM.vehicleTypeToChoose = vehicleType;
                                            },
                                            child: Row(children: [
                                              ConstrainedBox(
                                                  constraints:
                                                      BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 70),
                                                  child: Text(VehicleType.values[i].fullName,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:
                                                              isVehicleChosen ? ColorPallete.violetBlue : Colors.grey,
                                                          fontSize: 18))),
                                              const Spacer(),
                                              isVehicleChosen
                                                  ? SvgPicture.asset(Asset.checkmarkRounded.path, height: 26)
                                                  : Container()
                                            ])));
                                  }
                                  return Container();
                                })))),
                        AnimatedOpacity(
                            opacity: isSelected ? 1 : 0,
                            duration: animationDuration,
                            child: Container(color: Colors.black, height: 1))
                      ]);
                    }))))));
  }
}
