import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/model/charging_place/charging_place.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:chargeme/view/charging_place/stations_list_view.dart';
import 'package:chargeme/view/helper_views/svg_colored_icon.dart';
import 'package:chargeme/view_model/check_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CheckInOptionsView extends StatefulWidget {
  ChargingPlace? place;

  CheckInOptionsView({this.place, Key? key}) : super(key: key);

  @override
  _CheckInOptionsView createState() => _CheckInOptionsView();
}

class _CheckInOptionsView extends State<CheckInOptionsView> {
  int selectedStation = 0;
  int selectedOutlet = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Check in"), backgroundColor: ColorPallete.violetBlue),
        body: Consumer<CheckInViewModel>(
            builder: (context, checkInVM, child) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(padding: EdgeInsets.all(8), child: topView(checkInVM.screenOption)),
                  Container(height: 0.5, color: ColorPallete.violetBlue),
                  const SizedBox(height: 12),
                  checkInVM.screenOption == null ? nullFullView() : fullViewByOption(checkInVM.screenOption!)
                ])));
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
                        var viewModel = Provider.of<CheckInViewModel>(context, listen: false);
                        viewModel.screenOption = null;
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
            Text(widget.place!.name),
            const Spacer()
          ])
        : checkInRowByOption(screenOption);
  }

  Widget checkInRowByOption(ScreenOption option) {
    switch (option) {
      case ScreenOption.success:
        return checkInRow("assets/icons/common/checkmarkRounded.svg", "Successfullty charged", () {},
            shouldShowClose: true);
      case ScreenOption.couldNotCharge:
        return checkInRow("assets/icons/common/xmarkRounded.svg", "Could not charge", () {}, shouldShowClose: true);
      case ScreenOption.comment:
        return checkInRow("assets/icons/common/infoRounded.svg", "Comment only", () {}, shouldShowClose: true);
      case ScreenOption.charging:
        return checkInRow("assets/icons/common/charging.svg", "Charging now", () {}, shouldShowClose: true);
      case ScreenOption.waiting:
        return checkInRow("assets/icons/common/waitingForCharge.svg", "Waiting for charge", () {},
            shouldShowClose: true);
    }
  }

  Widget fullViewCommon() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Comment", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          TextFormField(
            minLines: 3,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                fillColor: ColorPallete.violetBlue,
                disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorPallete.violetBlue)),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorPallete.violetBlue)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorPallete.violetBlue))),
            onChanged: (text) {
              // var model = Provider.of<AddStationViewModel>(context, listen: false);
              // model.description = text;
            },
          ),
          SizedBox(height: 12),
          Text("Outlet", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          choosingOutlet()
        ]));
  }

  Widget choosingOutlet() {
    final stations = widget.place!.stations;
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
                  final isChosen = selectedStation == i && selectedOutlet == j;
                  return Container(
                      decoration: isChosen
                          ? BoxDecoration(border: Border.all(color: ColorPallete.violetBlue, width: 1))
                          : const BoxDecoration(),
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedStation = i;
                                  selectedOutlet = j;
                                });
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
      Text("My vehicle", style: TextStyle(fontSize: 16)),
      Text("---", style: TextStyle(fontSize: 24)),
      GestureDetector(onTap: () {}, child: Text("Update", style: TextStyle(color: ColorPallete.violetBlue))),
      const SizedBox(height: 12),
      checkInRow("assets/icons/common/checkmarkRounded.svg", "Successfullty charged", () {
        var viewModel = Provider.of<CheckInViewModel>(context, listen: false);
        viewModel.screenOption = ScreenOption.success;
      }),
      checkInRow("assets/icons/common/xmarkRounded.svg", "Could not charge", () {
        var viewModel = Provider.of<CheckInViewModel>(context, listen: false);
        viewModel.screenOption = ScreenOption.couldNotCharge;
      }),
      checkInRow("assets/icons/common/infoRounded.svg", "Comment only", () {
        var viewModel = Provider.of<CheckInViewModel>(context, listen: false);
        viewModel.screenOption = ScreenOption.comment;
      }),
      checkInRow("assets/icons/common/charging.svg", "Charging now", () {
        var viewModel = Provider.of<CheckInViewModel>(context, listen: false);
        viewModel.screenOption = ScreenOption.charging;
      }),
      checkInRow("assets/icons/common/waitingForCharge.svg", "Waiting for charge", () {
        var viewModel = Provider.of<CheckInViewModel>(context, listen: false);
        viewModel.screenOption = ScreenOption.waiting;
      })
    ]);
  }

  Widget successFullView() {
    return Column(children: [fullViewCommon()]);
  }

  Widget couldNotChargeFullView() {
    return Column(children: [fullViewCommon()]);
  }

  Widget commentFullView() {
    return Column(children: [fullViewCommon()]);
  }

  Widget chargingFullView() {
    return Column(children: [fullViewCommon()]);
  }

  Widget waitingFullView() {
    return Column(children: [fullViewCommon()]);
  }
}
