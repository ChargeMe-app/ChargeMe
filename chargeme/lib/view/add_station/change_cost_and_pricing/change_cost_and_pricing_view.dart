import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/gen/l10n.dart';
import 'package:chargeme/view_model/add_station_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeCostAndPricingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(L10n.changeCostAndPricing.str),
          backgroundColor: ColorPallete.violetBlue,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Consumer<AddStationViewModel>(
              builder: (context, addStationVM, child) => Column(children: [
                    Row(children: [
                      Text(
                        "${L10n.requiresFee.str}?",
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
                      initialValue: addStationVM.costDescription,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: L10n.costAndPricing.str,
                      ),
                      onChanged: (text) {
                        addStationVM.costDescription = text;
                      },
                    )
                  ])),
        ));
  }
}
