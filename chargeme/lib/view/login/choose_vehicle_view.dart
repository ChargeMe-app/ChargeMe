import 'dart:convert';

import 'package:chargeme/components/account_manager/account_manager.dart';
import 'package:chargeme/components/analytics_manager/analytics_manager.dart';
import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/gen/assets.dart';
import 'package:chargeme/model/charging_place/vehicle_type.dart';
import 'package:chargeme/extensions/string_extensions.dart';
import 'package:chargeme/view/helper_views/app_bar_with_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:chargeme/components/helpers/ip.dart';

class ChooseVehicleViewModel extends ChangeNotifier {
  final AccountManager accountManager;
  final AnalyticsManager analyticsManager;

  bool _hasVehicles = true;
  List<VehicleType> userVehicles = [VehicleType.nissanLeaf, VehicleType.teslaModel3];

  int? _shownManufacturerIndex;
  VehicleType? _chosenVehicleType;

  double rotation = 0.0;

  ChooseVehicleViewModel({required this.accountManager, required this.analyticsManager});

  int? get shownManufacturerIndex => _shownManufacturerIndex;
  set shownManufacturerIndex(int? value) {
    _shownManufacturerIndex = value;
    if (value == null) {
      rotation = 0.0;
    } else {
      rotation = 4.0 / 8.0;
    }
    notifyListeners();
  }

  VehicleType? get chosenVehicleType => _chosenVehicleType;
  set chosenVehicleType(VehicleType? value) {
    _chosenVehicleType = value;
    notifyListeners();
  }

  Future<void> setChosenVehicleType() async {
    if (accountManager.currentAccount == null || chosenVehicleType == null) return;
    Map<String, dynamic> postBody = {
      "user_id": accountManager.currentAccount!.id,
      "vehicle_type": chosenVehicleType?.value,
    };
    try {
      final response =
          await http.post(Uri.parse("http://${IP.current}:8080/v1/user/vehicle"), body: jsonEncode(postBody));
      if (response.statusCode == 200) {
        print("123");
      }
    } catch (error) {
      analyticsManager.logErrorEvent(error.toString());
    }
  }
}

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
                                  bool isVehicleChosen = vehicleType == chooseVehicleVM.chosenVehicleType;
                                  if (vehicleType.manufacturer == manufacturer) {
                                    return Padding(
                                        padding: EdgeInsets.fromLTRB(32, 8, 8, 8),
                                        child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () {
                                              chooseVehicleVM.chosenVehicleType = vehicleType;
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
