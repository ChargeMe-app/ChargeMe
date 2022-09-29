import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/view/add_station/change_access/change_access_view.dart';
import 'package:chargeme/view/add_station/change_amenities/change_amenities_view.dart';
import 'package:chargeme/view/add_station/change_cost_and_pricing/change_cost_and_pricing_view.dart';
import 'package:chargeme/view/add_station/change_hours/change_hours_view.dart';
import 'package:chargeme/view/add_station/change_location/choose_location_view.dart';
import 'package:chargeme/view/add_station/change_location_open/change_location_open_or_active_view.dart';
import 'package:chargeme/view/add_station/change_station_name/change_station_name_view.dart';
import 'package:chargeme/view/add_station/change_station_address/change_station_address_view.dart';
import 'package:chargeme/view/add_station/change_station_description/change_station_description_view.dart';
import 'package:chargeme/view/add_station/change_station_phone/change_station_phone_view.dart';
import 'package:chargeme/view/add_station/change_station_types/change_station_types.dart';
import 'package:chargeme/view/helper_views/app_bar_with_events.dart';
import 'package:chargeme/view_model/add_station_view_model.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:chargeme/extensions/string_extensions.dart';
import 'package:chargeme/extensions/location_extensions.dart';

class AddStationView extends StatefulWidget {
  const AddStationView({Key? key}) : super(key: key);

  @override
  _AddStationViewState createState() => _AddStationViewState();
}

class _AddStationViewState extends State<AddStationView> {
  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    return Consumer<AddStationViewModel>(
        builder: (context, viewModel, child) => Scaffold(
            appBar: AppBarWithEvents.create(
              context: context,
              title: viewModel.isEditingLocationMode ? Text("Edit location") : Text("Add new location"),
              onBackButtonPressed: () {
                viewModel.clearAfterEditing();
              },
              // actions: [
              //   CupertinoButton(
              //       child: Padding(
              //           padding: EdgeInsets.symmetric(horizontal: 0),
              //           child: Center(
              //               child: Text(viewModel.isEditingLocationMode ? "Save" : "Create",
              //                   style: TextStyle(
              //                       color: viewModel.isAbleToCreate() ? Colors.white : Colors.grey, fontSize: 16)))),
              //       onPressed: () {
              //         viewModel.createLocation();
              //       })
            ),
            body: ListView(
              children: viewModel.isHomeCharger
                  ? [
                      CardEntry(l10n.description, viewModel.description, false, (_) => ChangeStationDescriptionView()),
                      CardEntry(
                          l10n.location,
                          viewModel.location == null ? "" : "Successfully set",
                          true,
                          (_) => ChooseLocationView(
                              onLocationChosen: (address, latlng) => viewModel.setLocation(address, latlng),
                              initialMarkerPosition: viewModel.location?.latLng)),
                      CardEntry(l10n.address, viewModel.address, false, (_) => ChangeStationAddressView()),
                      CardEntry(l10n.stations, viewModel.stations.isEmpty ? "" : viewModel.stations.length.toString(),
                          true, (_) => ChangeStationTypesView()),
                      CardEntry(
                          l10n.hours,
                          viewModel.isOpen247 ? l10n.open247 : (viewModel.hours.isEmpty ? l10n.empty : viewModel.hours),
                          false,
                          (_) => ChangeHoursView()),
                      CardEntry(l10n.amenities, viewModel.amenities.map((e) => e.localizedTitle(context)).join(", "),
                          false, (_) => ChangeAmenitiesView()),
                    ]
                  : [
                      CardEntry(l10n.name, viewModel.name, true, (_) => ChangeStationNameView()),
                      CardEntry(l10n.description, viewModel.description, false, (_) => ChangeStationDescriptionView()),
                      CardEntry(l10n.phoneNumber, viewModel.phoneNumber, false, (_) => ChangeStationPhoneView()),
                      CardEntry(
                          l10n.location,
                          viewModel.location == null ? "" : "Successfully set",
                          true,
                          (_) => ChooseLocationView(
                              onLocationChosen: (address, latlng) => viewModel.setLocation(address, latlng),
                              initialMarkerPosition: viewModel.location?.latLng)),
                      CardEntry(l10n.address, viewModel.address, false, (_) => ChangeStationAddressView()),
                      CardEntry(l10n.stations, viewModel.stations.isEmpty ? "" : viewModel.stations.length.toString(),
                          true, (_) => ChangeStationTypesView()),
                      CardEntry(l10n.access, viewModel.access.name.capitalize, false, (_) => ChangeAccessView()),
                      CardEntry(
                          l10n.costAndPricing,
                          viewModel.requiresFee ? "${l10n.requiresFee}: ${viewModel.costDescription}" : l10n.free,
                          false,
                          (_) => ChangeCostAndPricingView()),
                      CardEntry(
                          l10n.hours,
                          viewModel.isOpen247 ? l10n.open247 : (viewModel.hours.isEmpty ? l10n.empty : viewModel.hours),
                          false,
                          (_) => ChangeHoursView()),
                      CardEntry(l10n.amenities, viewModel.amenities.map((e) => e.localizedTitle(context)).join(", "),
                          false, (_) => ChangeAmenitiesView()),
                      CardEntry(
                          "Location Open or Active?",
                          viewModel.isOpenOrActive ? l10n.locationIsActive : l10n.locationComingSoon,
                          true,
                          (_) => ChangeIsOpenOrActiveView()),
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
    return Consumer<AddStationViewModel>(
        builder: (context, viewModel, child) => Card(
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
            ));
  }
}
