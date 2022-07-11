import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/view/add_station/change_station_location/change_station_location_view.dart';
import 'package:chargeme/view/add_station/change_station_name/change_station_name_view.dart';
import 'package:chargeme/view/add_station/change_station_address/change_station_address_view.dart';
import 'package:chargeme/view/add_station/change_station_description/change_station_description_view.dart';
import 'package:chargeme/view/add_station/change_station_phone/change_station_phone_view.dart';
import 'package:chargeme/view/add_station/change_station_types/change_station_types.dart';
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
    return Scaffold(
        appBar: AppBar(title: const Text('Add station'), backgroundColor: ColorPallete.violetBlue),
        body: Consumer<AddStationViewModel>(
            builder: (context, viewModel, child) => ListView(
                  children: [
                    CardEntry("Name", viewModel.name, true, (_) => ChangeStationNameView()),
                    CardEntry("Description", viewModel.description, false, (_) => ChangeStationDescriptionView()),
                    CardEntry("Phone number", viewModel.phoneNumber, false, (_) => ChangeStationPhoneView()),
                    CardEntry("Address", viewModel.address, false, (_) => ChangeStationAddressView()),
                    CardEntry("Location", viewModel.location == null ? "" : "Successfully set", true,
                        (_) => ChangeStationLocationView()),
                    CardEntry(
                        "Stations",
                        viewModel.stationTypes.isEmpty ? "" : viewModel.stationTypes.length.toString(),
                        true,
                        (_) => ChangeStationTypesView())
                  ],
                )));
  }
}

class CardEntry extends StatelessWidget {
  CardEntry(this.title, this.subtitle, this.isFieldRequired, this.nextViewBuilder);

  final String title;
  final String subtitle;
  final bool isFieldRequired;
  final Widget Function(BuildContext) nextViewBuilder;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: isFieldRequired
                  ? TextStyle(color: subtitle.isEmpty ? ColorPallete.redCinnabar : Colors.black)
                  : const TextStyle()),
          subtitle.isEmpty ? Container() : Text(subtitle, maxLines: 1, style: const TextStyle(fontSize: 12))
        ]),
        trailing: const Icon(Icons.keyboard_arrow_right_sharp),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => nextViewBuilder(context),
            ),
          );
        },
      ),
    );
  }
}
