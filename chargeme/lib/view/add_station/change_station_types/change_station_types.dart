import 'dart:io';

import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:chargeme/view/charging_place/stations_list_view.dart';
import 'package:chargeme/view/login/phone_register_view.dart';
import 'package:chargeme/view_model/add_station_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeStationTypesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.editStationTypes),
        backgroundColor: ColorPallete.violetBlue,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Consumer<AddStationViewModel>(
              builder: (context, addStationVM, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Spacer(),
                        Text(
                          l10n.stations,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Spacer()
                      ]),
                      addStationVM.stations.isEmpty
                          ? Text(l10n.noAddedStations)
                          : Column(
                              children: List.generate(addStationVM.stations.length, (i) {
                              return Column(children: [
                                BoxWithTitle(
                                    title: "Station ${i + 1}",
                                    toolbar: GestureDetector(
                                        onTap: () {
                                          var viewModel = Provider.of<AddStationViewModel>(context, listen: false);
                                          viewModel.removeStation(i);
                                        },
                                        child: Icon(CupertinoIcons.minus_circle_fill, color: ColorPallete.redCinnabar)),
                                    children: [
                                      Row(children: [Text("Plugs:"), Spacer()]),
                                      const SizedBox(width: 8),
                                      Container(
                                          height: 120,
                                          child: ListView(scrollDirection: Axis.horizontal, children: [
                                            Row(
                                                children: List.generate(addStationVM.stations[i].outlets.length, (j) {
                                              final outlet = addStationVM.stations[i].outlets[j];
                                              return Row(children: [
                                                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                  Container(
                                                      width: 64,
                                                      height: 64,
                                                      child: Image.asset(outlet.connectorType.iconPath,
                                                          color: ColorPallete.violetBlue)),
                                                  Text(outlet.connectorType.str),
                                                  GestureDetector(
                                                      onTap: () {
                                                        var viewModel =
                                                            Provider.of<AddStationViewModel>(context, listen: false);
                                                        viewModel.removeOutlet(i, j);
                                                      },
                                                      child:
                                                          Icon(CupertinoIcons.delete, color: ColorPallete.redCinnabar))
                                                ]),
                                                SizedBox(width: 4)
                                              ]);
                                            })),
                                            Container(
                                                height: 10,
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(primary: ColorPallete.violetBlue),
                                                    child: Text("Add plug"),
                                                    onPressed: () => showPickerArray(context, i)))
                                          ])),
                                      const SizedBox(height: 8)
                                    ]),
                                const SizedBox(height: 8)
                              ]);
                            }))
                    ],
                  ))),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          var viewModel = Provider.of<AddStationViewModel>(context, listen: false);
          viewModel.addEmptyStation();
        },
        icon: const Icon(Icons.add),
        label: Text(l10n.addStation),
      ),
    );
  }

  showPickerArray(BuildContext context, int i) {
    var l10n = AppLocalizations.of(context);
    List<PickerItem> pickerItems = [];
    for (var connectorType in ConnectorType.values) {
      if (connectorType == ConnectorType.unknown) continue;
      pickerItems.add(PickerItem(
          value: connectorType,
          text: Row(children: [
            Spacer(),
            Padding(padding: EdgeInsets.all(8), child: Image.asset(connectorType.iconPath)),
            Text(connectorType.str, style: TextStyle(fontSize: 18, color: Colors.black)),
            Spacer()
          ])));
    }
    Picker(
      adapter: PickerDataAdapter(data: pickerItems),
      itemExtent: 52,
      title: Text("Select plug"),
      selectedTextStyle: TextStyle(color: Colors.blue, fontSize: 12),
      onConfirm: (Picker picker, List value) {
        var viewModel = Provider.of<AddStationViewModel>(context, listen: false);
        viewModel.addEmptyOutlet(i, picker.getSelectedValues()[0]);
        print(value.toString());
        print(picker.getSelectedValues());
      },
    ).showModal(context);
  }
}

Widget _buildBottomPicker(Widget picker) {
  return Container(
    height: 200,
    padding: const EdgeInsets.only(top: 6.0),
    color: CupertinoColors.white,
    child: DefaultTextStyle(
      style: const TextStyle(
        color: CupertinoColors.black,
        fontSize: 22.0,
      ),
      child: GestureDetector(
        onTap: () {},
        child: SafeArea(
          top: false,
          child: picker,
        ),
      ),
    ),
  );
}
