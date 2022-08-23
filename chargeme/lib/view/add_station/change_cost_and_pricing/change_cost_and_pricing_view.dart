import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:chargeme/view/add_station/add_station_view.dart';
import 'package:chargeme/view_model/add_station_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeCostAndPricingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Change access"),
          backgroundColor: ColorPallete.violetBlue,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Consumer<AddStationViewModel>(
              builder: (context, addStationVM, child) => Column(children: [
                    Row(children: [
                      Text(
                        "Requires fee?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      CupertinoSwitch(
                          value: addStationVM.requiresFee,
                          onChanged: (isOn) {
                            addStationVM.requiresFee = isOn;
                          })
                    ]),
                    SizedBox(height: 8),
                    TextFormField(
                      enabled: addStationVM.requiresFee,
                      minLines: 3,
                      initialValue: addStationVM.description,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Cost description",
                      ),
                      onChanged: (text) {
                        addStationVM.costDescription = text;
                      },
                    )
                  ])),
        ));
  }
}
