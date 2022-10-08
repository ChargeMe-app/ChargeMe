import 'package:chargeme/components/account_manager/account_manager.dart';
import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/gen/assets.dart';
import 'package:chargeme/gen/l10n.dart';
import 'package:chargeme/model/vehicle/vehicle_type.dart';
import 'package:chargeme/view/login/choose_vehicle_view.dart';
import 'package:chargeme/view/login/phone_register_view.dart';
import 'package:chargeme/view_model/choose_vehicle_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class UserVehiclesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(L10n.chooseVehicle.str),
            actions: [
              context.read<ChooseVehicleViewModel>().onlyChoosing
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        context.read<ChooseVehicleViewModel>().isEditMode =
                            !context.read<ChooseVehicleViewModel>().isEditMode;
                      },
                      child: const Padding(padding: EdgeInsets.only(right: 12), child: Icon(CupertinoIcons.pencil)))
            ],
            backgroundColor: ColorPallete.violetBlue),
        body: Consumer<ChooseVehicleViewModel>(
            builder: (context, chooseVehicleVM, child) => Column(children: [
                  SingleChildScrollView(
                      child: Column(
                          children: List.generate(chooseVehicleVM.vehicles.length, (i) {
                    final vehicle = chooseVehicleVM.vehicles[i];
                    return InkWell(
                        onTap: () async {
                          await chooseVehicleVM.savePreferredVehicleType(vehicle);
                          if (chooseVehicleVM.onlyChoosing) {
                            chooseVehicleVM.onlyChoosing = false;
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 0.5, color: ColorPallete.violetBlue))),
                            child: ListTile(
                                title: Text(vehicle.type.fullName),
                                trailing: chooseVehicleVM.isEditMode
                                    ? SizedBox(
                                        width: 28,
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(CupertinoIcons.trash, color: ColorPallete.redCinnabar)))
                                    : (chooseVehicleVM.chosenVehicle == vehicle
                                        ? SvgPicture.asset(Asset.checkmarkRounded.path, height: 24, width: 24)
                                        : const SizedBox()))));
                  }))),
                  const Spacer(),
                  chooseVehicleVM.onlyChoosing
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 24),
                          child: SimpleButton(
                              color: ColorPallete.violetBlue,
                              text: L10n.addVehicle.str,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseVehicleView()));
                              }))
                ])));
  }
}
