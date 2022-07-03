import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/view/AddStation/ChangeStationNameView/ChangeStationNameView.dart';
import 'package:chargeme/view/AddStation/change_station_address/change_station_address_view.dart';
import 'package:chargeme/view/AddStation/change_station_description/change_station_description_view.dart';
import 'package:chargeme/view/AddStation/change_station_phone/change_station_phone_view.dart';
import 'package:chargeme/view/AddStation/change_station_types/change_station_types.dart';
import 'package:chargeme/view_model/AddStationViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddStationView extends StatefulWidget {
  const AddStationView({Key? key}) : super(key: key);

  @override
  _AddStationViewState createState() => _AddStationViewState();
}

class _AddStationViewState extends State<AddStationView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddStationViewModel>(
        builder: (context, viewModel, child) => ListView(
              children: [
                Card(
                  child: ListTile(
                    title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text("Name",
                          style: TextStyle(color: viewModel.name.isEmpty ? ColorPallete.redCinnabar : Colors.black)),
                      viewModel.name.isEmpty ? Container() : Text(viewModel.name, style: TextStyle(fontSize: 12))
                    ]),
                    trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeStationNameView(),
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Text("Description"),
                      viewModel.description.isEmpty
                          ? Container()
                          : Text(viewModel.description, maxLines: 1, style: const TextStyle(fontSize: 12))
                    ]),
                    trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeStationDescriptionView(),
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Text("Phone number"),
                      viewModel.phoneNumber.isEmpty
                          ? Container()
                          : Text(viewModel.phoneNumber, maxLines: 1, style: const TextStyle(fontSize: 12))
                    ]),
                    trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeStationPhoneView(),
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Text("Address"),
                      viewModel.address.isEmpty
                          ? Container()
                          : Text(viewModel.phoneNumber, maxLines: 1, style: const TextStyle(fontSize: 12))
                    ]),
                    trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeStationAddressView(),
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Text("Location (process to map)"),
                      viewModel.address.isEmpty
                          ? Container()
                          : Text(viewModel.phoneNumber, maxLines: 1, style: const TextStyle(fontSize: 12))
                    ]),
                    trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeStationAddressView(),
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text("Stations",
                          style: TextStyle(
                              color: viewModel.stationTypes.isEmpty ? ColorPallete.redCinnabar : Colors.black)),
                      viewModel.stationTypes.isEmpty
                          ? Container()
                          : Text("${viewModel.stationTypes.length} stations", style: TextStyle(fontSize: 12))
                    ]),
                    trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeStationTypesView(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ));
  }
}
