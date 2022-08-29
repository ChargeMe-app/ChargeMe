import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:chargeme/view_model/add_station_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeIsOpenOrActiveView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Change open or active status"),
        backgroundColor: ColorPallete.violetBlue,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Row(children: [
            Text(
              "Is this location open/active?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Consumer<AddStationViewModel>(
                builder: (context, addStationVM, child) => CupertinoSwitch(
                    value: addStationVM.isOpenOrActive,
                    onChanged: (isOn) {
                      addStationVM.isOpenOrActive = isOn;
                    }))
          ])),
    );
  }
}
