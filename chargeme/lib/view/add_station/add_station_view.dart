import 'package:chargeme/components/root_observer/root_observer.dart';
import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/gen/l10n.dart';
import 'package:chargeme/view/add_station/change_access/change_access_view.dart';
import 'package:chargeme/view/add_station/change_amenities/change_amenities_view.dart';
import 'package:chargeme/view/add_station/change_cost_and_pricing/change_cost_and_pricing_view.dart';
import 'package:chargeme/view/add_station/change_hours/change_hours_view.dart';
import 'package:chargeme/view/add_station/change_location/choose_location_view.dart';
import 'package:chargeme/view/add_station/change_station_name/change_station_name_view.dart';
import 'package:chargeme/view/add_station/change_station_address/change_station_address_view.dart';
import 'package:chargeme/view/add_station/change_station_description/change_station_description_view.dart';
import 'package:chargeme/view/add_station/change_station_phone/change_station_phone_view.dart';
import 'package:chargeme/view/add_station/change_station_types/change_station_types.dart';
import 'package:chargeme/view_model/add_station_view_model.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chargeme/extensions/string_extensions.dart';
import 'package:chargeme/extensions/location_extensions.dart';

class AddStationView extends StatefulWidget {
  const AddStationView({Key? key}) : super(key: key);

  @override
  _AddStationViewState createState() => _AddStationViewState();
}

class _AddStationViewState extends State<AddStationView> with RouteAware {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
    super.initState();
  }

  @override
  void didPop() {
    final chooseVehicleVM = Provider.of<AddStationViewModel>(context, listen: false);
    chooseVehicleVM.resetModel();
    super.didPop();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddStationViewModel>(
        builder: (context, viewModel, child) => Scaffold(
            appBar: AppBar(
                backgroundColor: ColorPallete.violetBlue,
                title: viewModel.isEditingLocationMode ? Text(L10n.editLocation.str) : Text(L10n.addNewLocation.str),
                actions: [
                  CupertinoButton(
                      child: Center(
                          child: Text(viewModel.isEditingLocationMode ? L10n.save.str : L10n.create.str,
                              style: TextStyle(
                                  color: viewModel.isAbleToCreate() ? Colors.white : Colors.grey, fontSize: 16))),
                      onPressed: () {
                        viewModel.createLocation();
                        viewModel.resetModel();
                        Navigator.pop(context);
                      })
                ]),
            body: ListView(
              children: viewModel.isHomeCharger
                  ? [
                      CardEntry(
                          L10n.description.str, viewModel.description, false, (_) => ChangeStationDescriptionView()),
                      CardEntry(
                          L10n.location.str,
                          viewModel.location == null ? "" : L10n.successfullySet.str,
                          true,
                          (_) => ChooseLocationView(
                              onLocationChosen: (address, latlng) => viewModel.setLocation(address, latlng),
                              initialMarkerPosition: viewModel.location?.latLng)),
                      CardEntry(L10n.address.str, viewModel.address, false, (_) => ChangeStationAddressView()),
                      CardEntry(
                          L10n.stations.str,
                          viewModel.stations.isEmpty ? "" : viewModel.stations.length.toString(),
                          true,
                          (_) => ChangeStationTypesView()),
                      CardEntry(
                          L10n.hours.str,
                          viewModel.isOpen247
                              ? L10n.open247.str
                              : (viewModel.hours.isEmpty ? L10n.empty.str : viewModel.hours),
                          false,
                          (_) => ChangeHoursView()),
                      CardEntry(L10n.amenities.str, viewModel.amenities.map((e) => e.localizedTitle).join(", "), false,
                          (_) => ChangeAmenitiesView()),
                    ]
                  : [
                      CardEntry(L10n.name.str, viewModel.name, true, (_) => ChangeStationNameView()),
                      CardEntry(
                          L10n.description.str, viewModel.description, false, (_) => ChangeStationDescriptionView()),
                      CardEntry(L10n.phoneNumber.str, viewModel.phoneNumber, false, (_) => ChangeStationPhoneView()),
                      viewModel.isEditingLocationMode
                          ? Container()
                          : CardEntry(
                              L10n.location.str,
                              viewModel.location == null ? "" : L10n.successfullySet.str,
                              true,
                              (_) => ChooseLocationView(
                                  onLocationChosen: (address, latlng) => viewModel.setLocation(address, latlng),
                                  initialMarkerPosition: viewModel.location?.latLng)),
                      viewModel.isEditingLocationMode
                          ? Container()
                          : CardEntry(L10n.address.str, viewModel.address, false, (_) => ChangeStationAddressView()),
                      CardEntry(
                          L10n.stations.str,
                          viewModel.stations.isEmpty ? "" : viewModel.stations.length.toString(),
                          true,
                          (_) => ChangeStationTypesView()),
                      CardEntry(L10n.access.str, viewModel.access.localizedTitle.capitalize, false,
                          (_) => ChangeAccessView()),
                      CardEntry(
                          L10n.costAndPricing.str,
                          viewModel.requiresFee
                              ? "${L10n.requiresFee.str}: ${viewModel.costDescription}"
                              : L10n.free.str,
                          false,
                          (_) => ChangeCostAndPricingView()),
                      CardEntry(
                          L10n.hours.str,
                          viewModel.isOpen247
                              ? L10n.open247.str
                              : (viewModel.hours.isEmpty ? L10n.empty.str : viewModel.hours),
                          false,
                          (_) => ChangeHoursView()),
                      CardEntry(L10n.amenities.str, viewModel.amenities.map((e) => e.localizedTitle).join(", "), false,
                          (_) => ChangeAmenitiesView())
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
