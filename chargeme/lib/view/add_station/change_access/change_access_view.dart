import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:chargeme/view_model/add_station_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeAccessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Change access"),
        backgroundColor: ColorPallete.violetBlue,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Row(children: [
            Text(
              "Is this location restricted?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Consumer<AddStationViewModel>(
                builder: (context, addStationVM, child) => CupertinoSwitch(
                    value: addStationVM.access == Access.restricted,
                    onChanged: (isOn) {
                      addStationVM.access = isOn ? Access.restricted : Access.public;
                    }))
          ])),
    );
  }
}
