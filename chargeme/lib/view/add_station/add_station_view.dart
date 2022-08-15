import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/view/add_station/change_station_location/change_station_location_view.dart';
import 'package:chargeme/view/add_station/change_station_name/change_station_name_view.dart';
import 'package:chargeme/view/add_station/change_station_address/change_station_address_view.dart';
import 'package:chargeme/view/add_station/change_station_description/change_station_description_view.dart';
import 'package:chargeme/view/add_station/change_station_phone/change_station_phone_view.dart';
import 'package:chargeme/view/add_station/change_station_types/change_station_types.dart';
import 'package:chargeme/view_model/add_station_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddStationView extends StatefulWidget {
  const AddStationView({Key? key}) : super(key: key);

  @override
  _AddStationViewState createState() => _AddStationViewState();
}

class _AddStationViewState extends State<AddStationView> {
  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(title: Text(l10n.addStation), backgroundColor: ColorPallete.violetBlue),
        body: Consumer<AddStationViewModel>(
            builder: (context, viewModel, child) => ListView(
                  children: [
                    CardEntry(l10n.name, viewModel.name, true, (_) => ChangeStationNameView()),
                    CardEntry(l10n.description, viewModel.description, false, (_) => ChangeStationDescriptionView()),
                    CardEntry(l10n.phoneNumber, viewModel.phoneNumber, false, (_) => ChangeStationPhoneView()),
                    CardEntry(l10n.address, viewModel.address, false, (_) => ChangeStationAddressView()),
                    CardEntry(l10n.location, viewModel.location == null ? "" : "Successfully set", true,
                        (_) => ChangeStationLocationView()),
                    CardEntry(l10n.stations, viewModel.stations.isEmpty ? "" : viewModel.stations.length.toString(),
                        true, (_) => ChangeStationTypesView())
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
