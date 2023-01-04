import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/gen/l10n.dart';
import 'package:chargeme/view/helper_views/designed_switch.dart';
import 'package:chargeme/view_model/add_station_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeIsOpenOrActiveView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidthWithPadding = MediaQuery.of(context).size.width - 16;
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.locationOpenOrActive.str),
        backgroundColor: ColorPallete.violetBlue,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Row(children: [
            SizedBox(
                width: screenWidthWithPadding - 82,
                child: Text(
                  "${L10n.areStationsInUse.str}?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            const Spacer(),
            Consumer<AddStationViewModel>(
                builder: (context, addStationVM, child) => DesignedSwitch(
                    value: addStationVM.isOpenOrActive,
                    onChanged: (isOn) {
                      addStationVM.isOpenOrActive = isOn;
                    }))
          ])),
    );
  }
}
