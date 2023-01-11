import 'dart:ui';

import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/gen/assets.dart';
import 'package:chargeme/gen/l10n.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:chargeme/model/vehicle/vehicle_type.dart';
import 'package:chargeme/view/login/choose_vehicle_view.dart';
import 'package:chargeme/view/login/phone_register_view.dart';
import 'package:chargeme/view/login/user_vehicles_view.dart';
import 'package:chargeme/view_model/check_in_view_model.dart';
import 'package:chargeme/view_model/choose_vehicle_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:duration_picker/duration_picker.dart';

class CheckInOptionsView extends StatefulWidget {
  CheckInOptionsView({Key? key}) : super(key: key);

  @override
  _CheckInOptionsView createState() => _CheckInOptionsView();
}

class _CheckInOptionsView extends State<CheckInOptionsView> {
  FocusNode commentFocusNode = FocusNode();
  FocusNode kilowattsFocusNode = FocusNode();
  CheckInViewModel get checkInVM {
    return Provider.of<CheckInViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(L10n.checkIn.str), backgroundColor: ColorPallete.violetBlue),
        body: Consumer<CheckInViewModel>(
            builder: (context, checkInVM, child) => SingleChildScrollView(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(padding: EdgeInsets.all(8), child: topView(checkInVM.screenOption)),
                  Container(height: 0.5, color: ColorPallete.violetBlue),
                  const SizedBox(height: 12),
                  checkInVM.screenOption == null ? nullFullView() : fullViewByOption(checkInVM.screenOption!)
                ]))));
  }

  Widget checkInRow(String iconPath, String title, Function onTap, {bool shouldShowClose = false}) {
    return GestureDetector(
        onTap: (() => onTap()),
        child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(children: [
              SvgPicture.asset(iconPath, height: 64),
              const SizedBox(width: 8),
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const Spacer(),
              shouldShowClose
                  ? GestureDetector(
                      onTap: () {
                        checkInVM.screenOption = null;
                      },
                      child: Icon(Icons.close, size: 32, color: Colors.grey))
                  : Container()
            ])));
  }

  Widget topView(ScreenOption? screenOption) {
    return screenOption == null
        ? Row(children: [
            SizedBox(height: 48, child: Image.asset("assets/icons/markers/publicFast64.png")),
            const SizedBox(width: 8),
            Text(checkInVM.place.name),
            const Spacer()
          ])
        : checkInRowByOption(screenOption);
  }

  Widget checkInRowByOption(ScreenOption option) {
    switch (option) {
      case ScreenOption.success:
        return checkInRow(Asset.checkmarkRounded.path, L10n.successfulltyCharged.str, () {}, shouldShowClose: true);
      case ScreenOption.couldNotCharge:
        return checkInRow(Asset.xmarkRounded.path, L10n.couldNotCharge.str, () {}, shouldShowClose: true);
      case ScreenOption.comment:
        return checkInRow(Asset.infoRounded.path, L10n.commentOnly.str, () {}, shouldShowClose: true);
      case ScreenOption.charging:
        return checkInRow(Asset.charging.path, L10n.chargingNow.str, () {}, shouldShowClose: true);
      case ScreenOption.waiting:
        return checkInRow(Asset.waitingForCharge.path, L10n.waitingForCharge.str, () {}, shouldShowClose: true);
    }
  }

  Widget titleText(String text) {
    return Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  Widget fullViewCommon() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            titleText(L10n.comment.str),
            Spacer(),
            CupertinoButton(
                padding: EdgeInsets.all(4),
                child: Text(L10n.done.str),
                onPressed: commentFocusNode.hasFocus
                    ? () {
                        setState(() {
                          commentFocusNode.unfocus();
                        });
                      }
                    : null)
          ]),
          SizedBox(height: 12),
          TextFormField(
            focusNode: commentFocusNode,
            minLines: 3,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                fillColor: ColorPallete.violetBlue,
                disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorPallete.violetBlue)),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorPallete.violetBlue)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorPallete.violetBlue))),
            onChanged: (text) {
              checkInVM.comment = text;
            },
          ),
          SizedBox(height: 12),
          titleText(L10n.outlet.str),
          SizedBox(height: 12),
          choosingOutlet()
        ]));
  }

  Widget choosingOutlet() {
    final stations = checkInVM.place.stations;
    return Container(
        height: 130,
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(stations.length, (i) {
              final outlets = stations[i].outlets;
              final isLast = stations.length - 1 == i;
              return Row(children: [
                Row(
                    children: List.generate(outlets.length, (j) {
                  var outlet = outlets[j];
                  final isChosen = checkInVM.selectedStation == i && checkInVM.selectedOutlet == j;
                  return Container(
                      decoration: isChosen
                          ? BoxDecoration(border: Border.all(color: ColorPallete.violetBlue, width: 1))
                          : const BoxDecoration(),
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: GestureDetector(
                              onTap: () {
                                checkInVM.setOutlet(i, j);
                              },
                              child: Column(children: [
                                Image.asset(outlet.connectorType.iconPath, height: 60, color: ColorPallete.violetBlue),
                                const SizedBox(height: 12),
                                Text(outlet.connectorType.str,
                                    style: TextStyle(
                                        color: ColorPallete.violetBlue, fontSize: 16, fontWeight: FontWeight.bold)),
                                Text(outlet.kilowatts == null ? "" : "${outlet.kilowatts?.toInt().toString()} kWh",
                                    style: TextStyle(fontSize: 12, color: ColorPallete.violetBlue))
                              ]))));
                })),
                SizedBox(width: 2),
                isLast ? Container() : Container(width: 1, color: ColorPallete.violetBlue),
                SizedBox(width: 2),
              ]);
            })));
  }

  Widget kilowattsInput() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          titleText(L10n.power.str),
          Row(children: [
            Text(L10n.maxKwhh.str),
            SizedBox(width: 12),
            SizedBox(
                height: 32,
                width: 92,
                child: TextFormField(
                  focusNode: kilowattsFocusNode,
                  textAlign: TextAlign.end,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  maxLines: 1,
                  decoration: InputDecoration(
                      fillColor: ColorPallete.violetBlue,
                      disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorPallete.violetBlue)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorPallete.violetBlue)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorPallete.violetBlue))),
                  onChanged: (text) {
                    checkInVM.setKilowatts(text);
                  },
                )),
            const Spacer(),
            CupertinoButton(
                padding: EdgeInsets.all(4),
                child: Text(L10n.done.str),
                onPressed: kilowattsFocusNode.hasFocus
                    ? () {
                        setState(() {
                          kilowattsFocusNode.unfocus();
                        });
                      }
                    : null)
          ])
        ]));
  }

  Widget timeInput() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(children: [
          Row(children: [titleText(L10n.duration.str), const Spacer()]),
          DurationPicker(
              duration: checkInVM.duration!,
              onChange: (value) {
                value = value.inMinutes > 20 * 60 ? const Duration(hours: 20) : value;
                checkInVM.setRoundedDuration(value);
              })
        ]));
  }

  Widget fullViewByOption(ScreenOption option) {
    switch (option) {
      case ScreenOption.success:
        return successFullView();
      case ScreenOption.couldNotCharge:
        return couldNotChargeFullView();
      case ScreenOption.comment:
        return commentFullView();
      case ScreenOption.charging:
        return chargingFullView();
      case ScreenOption.waiting:
        return waitingFullView();
    }
  }

  Widget nullFullView() {
    return Column(children: [
      Text(L10n.myVehicle.str, style: TextStyle(fontSize: 16)),
      checkInVM.vehicleType == null
          ? Text("--", style: TextStyle(fontSize: 24))
          : Text(checkInVM.vehicleType!.fullName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      Consumer<ChooseVehicleViewModel>(
          builder: (context, chooseVehicleVM, child) => GestureDetector(
              onTap: () {
                if (chooseVehicleVM.vehicles.isEmpty) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => ChooseVehicleView(shouldSelectOnPop: true)));
                } else {
                  chooseVehicleVM.onlyChoosing = true;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserVehiclesView()));
                }
              },
              child: Text(L10n.update.str, style: TextStyle(color: ColorPallete.violetBlue)))),
      const SizedBox(height: 12),
      checkInVM.isRepair
          ? Container()
          : checkInRow(Asset.checkmarkRounded.path, L10n.successfulltyCharged.str, () {
              checkInVM.screenOption = ScreenOption.success;
            }),
      checkInVM.isRepair
          ? Container()
          : checkInRow(Asset.xmarkRounded.path, L10n.couldNotCharge.str, () {
              checkInVM.screenOption = ScreenOption.couldNotCharge;
            }),
      checkInRow(Asset.infoRounded.path, L10n.commentOnly.str, () {
        checkInVM.screenOption = ScreenOption.comment;
      }),
      checkInVM.isRepair
          ? Container()
          : checkInRow(Asset.charging.path, L10n.chargingNow.str, () {
              checkInVM.screenOption = ScreenOption.charging;
            })
      // checkInRow(Asset.waitingForCharge.path, L10n.waitingForCharge.str, () {
      //   checkInVM.screenOption = ScreenOption.waiting;
      // })
    ]);
  }

  Widget publishReviewButton() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: SimpleButton(
            color: ColorPallete.violetBlue,
            text: L10n.publish.str,
            onPressed: () {
              checkInVM.sendCheckIn();
              Navigator.pop(context);
            }));
  }

  Widget successFullView() {
    return Column(children: [
      fullViewCommon(),
      const SizedBox(height: 12),
      kilowattsInput(),
      const SizedBox(height: 12),
      publishReviewButton()
    ]);
  }

  Widget couldNotChargeFullView() {
    return Column(children: [fullViewCommon(), const SizedBox(height: 12), publishReviewButton()]);
  }

  Widget commentFullView() {
    return Column(children: [fullViewCommon(), const SizedBox(height: 12), publishReviewButton()]);
  }

  Widget chargingFullView() {
    return Column(children: [
      fullViewCommon(),
      const SizedBox(height: 12),
      timeInput(),
      const SizedBox(height: 12),
      kilowattsInput(),
      const SizedBox(height: 12),
      publishReviewButton(),
      const SizedBox(height: 18)
    ]);
  }

  Widget waitingFullView() {
    return Column(children: [
      fullViewCommon(),
      const SizedBox(height: 12),
      timeInput(),
      const SizedBox(height: 12),
      publishReviewButton(),
      const SizedBox(height: 18)
    ]);
  }
}
