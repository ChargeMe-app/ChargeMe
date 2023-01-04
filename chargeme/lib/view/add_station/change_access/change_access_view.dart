import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/gen/l10n.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:chargeme/view/helper_views/designed_switch.dart';
import 'package:chargeme/view_model/add_station_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeAccessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.access.str),
        backgroundColor: ColorPallete.violetBlue,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Row(children: [
            Text(
              "${L10n.isThisLocationRestricted.str}?",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Consumer<AddStationViewModel>(
                builder: (context, addStationVM, child) => DesignedSwitch(
                    value: addStationVM.access == Access.restricted,
                    onChanged: (isOn) {
                      addStationVM.access = isOn ? Access.restricted : Access.public;
                    }))
          ])),
    );
  }
}
