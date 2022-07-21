import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/model/charging_place/station.dart';
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
                      Text(
                        l10n.stations,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      addStationVM.stationTypes.isEmpty ? Text(l10n.noAddedStations) : const Text("")
                    ],
                  ))),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showPickerArray(context);
        },
        icon: const Icon(Icons.add),
        label: Text(l10n.addStationType),
      ),
    );
  }

  showPickerArray(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    List<PickerItem> pickerItems = [];
    for (var stationType in ConnectorType.values) {
      pickerItems.add(PickerItem(
          text: Center(child: Text(stationType.toString(), style: TextStyle(fontSize: 18, color: Colors.black)))));
    }
    Picker(
      adapter: PickerDataAdapter(data: pickerItems),
      itemExtent: 40,
      title: Text(l10n.selectIcon),
      selectedTextStyle: TextStyle(color: Colors.blue, fontSize: 12),
      onConfirm: (Picker picker, List value) {
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
