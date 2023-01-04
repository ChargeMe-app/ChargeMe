import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/gen/l10n.dart';
import 'package:chargeme/view/helper_views/designed_switch.dart';
import 'package:chargeme/view_model/add_station_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeHoursView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(L10n.hours.str),
          backgroundColor: ColorPallete.violetBlue,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Consumer<AddStationViewModel>(
              builder: (context, addStationVM, child) => Column(children: [
                    Row(children: [
                      Text(
                        "${L10n.open247.str}?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      DesignedSwitch(
                          value: addStationVM.isOpen247,
                          onChanged: (isOn) {
                            addStationVM.isOpen247 = isOn;
                          })
                    ]),
                    const SizedBox(height: 8),
                    TextFormField(
                      enabled: !addStationVM.isOpen247,
                      initialValue: addStationVM.hours,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: L10n.workingHours.str,
                      ),
                      onChanged: (text) {
                        addStationVM.hours = text;
                      },
                    )
                  ])),
        ));
  }
}
