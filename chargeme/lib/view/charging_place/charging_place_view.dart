import 'package:chargeme/components/account_manager/account_manager.dart';
import 'package:chargeme/components/analytics_manager/analytics_manager.dart';
import 'package:chargeme/components/charging_place_manager/charging_place_manager.dart';
import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/gen/assets.dart';
import 'package:chargeme/model/charging_place/charging_place.dart';
import 'package:chargeme/view/add_station/add_station_view.dart';
import 'package:chargeme/view/charging_place/amenities_view.dart';
import 'package:chargeme/view/charging_place/check_in/check_in_options_view.dart';
import 'package:chargeme/view/charging_place/details_view.dart';
import 'package:chargeme/view/charging_place/reviews_view.dart';
import 'package:chargeme/view/charging_place/stations_list_view.dart';
import 'package:chargeme/view/helper_views/title_text.dart';
import 'package:chargeme/view/login/profile_view.dart';
import 'package:chargeme/view_model/add_station_view_model.dart';
import 'package:chargeme/view_model/check_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:chargeme/model/charging_place/charging_place.dart' as charging_place;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:chargeme/extensions/string_extensions.dart';
import 'package:provider/provider.dart';

class ChargingPlaceView extends StatefulWidget {
  const ChargingPlaceView(
      {Key? key, required this.id, required this.analyticsManager, required this.accountManager, this.icon})
      : super(key: key);

  final String id;
  final BitmapDescriptor? icon;
  final AnalyticsManager analyticsManager;
  final AccountManager accountManager;

  @override
  _ChargingPlaceView createState() => _ChargingPlaceView();
}

class _ChargingPlaceView extends State<ChargingPlaceView> {
  late final ChargingPlaceManager _chargingPlaceManager =
      ChargingPlaceManager(analyticsManager: widget.analyticsManager);
  ChargingPlace? place;
  double scrollUpOffset = 0;
  double imageContainerHeight = 200;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    setupChargingPlace();
  }

  void setupChargingPlace() async {
    place = await _chargingPlaceManager.getChargingPlace(id: widget.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    if (place == null) {
      return Scaffold(
          appBar: AppBar(title: Text(l10n.appTitle), backgroundColor: ColorPallete.violetBlue),
          body: Center(child: Text(l10n.loading)));
    } else {
      return Scaffold(
          appBar: AppBar(title: Text(l10n.appTitle), backgroundColor: ColorPallete.violetBlue, actions: [
            GestureDetector(
                onTap: () {
                  showActions();
                },
                child: Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: SizedBox(width: 32, child: Image.asset(Asset.threeDots.path))))
          ]),
          body: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                setState(() {
                  final scrollVerticalOffset = scrollNotification.metrics.pixels;
                  if (scrollVerticalOffset < 0) {
                    scrollUpOffset = -scrollVerticalOffset;
                  }
                });
                return true;
              },
              child: SingleChildScrollView(
                  child: Transform.translate(
                      offset: Offset(0, -scrollUpOffset),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              height: imageContainerHeight + scrollUpOffset,
                              color: Colors.grey,
                              child: const Image(
                                image: AssetImage("assets/temporary/test_photo.jpeg"),
                                width: double.infinity,
                                fit: BoxFit.fitWidth,
                              )),
                          ChargingPlaceTitleView(place: place!),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 24),
                              child: Column(children: [
                                CheckInButton(
                                    place: place,
                                    analyticsManager: widget.analyticsManager,
                                    accountManager: widget.accountManager),
                                const SizedBox(height: 10),
                                DetailsView(place: place!, icon: widget.icon),
                                const SizedBox(height: 10),
                                StationsListView(stations: place!.stations),
                                place!.amenities?.isEmpty ?? true ? Container() : const SizedBox(height: 10),
                                place!.amenities?.isEmpty ?? true
                                    ? Container()
                                    : AmenitiesView(amenities: place!.amenities!),
                                place!.reviews?.isEmpty ?? true ? Container() : const SizedBox(height: 10),
                                place!.reviews?.isEmpty ?? true
                                    ? Container()
                                    : ReviewsView(reviews: place!.reviews ?? []),
                                // const SizedBox(height: 10),
                                // ControlButtonsView(),
                              ]))
                        ],
                      )))));
    }
  }

  void showActions() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              color: Color(0xFF737373),
              height: 180,
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                  child: Column(children: [
                    Padding(padding: const EdgeInsets.all(8), child: TitleText("Actions")),
                    ListTile(
                        leading: SizedBox(width: 40, child: SvgPicture.asset(Asset.star.path)),
                        title:
                            Text("Add to favourites", style: TextStyle(fontSize: 18, color: ColorPallete.violetBlue)),
                        onTap: () {}),
                    ListTile(
                        leading: SizedBox(width: 40, child: SvgPicture.asset(Asset.info.path)),
                        title: Text("Edit", style: TextStyle(fontSize: 18, color: ColorPallete.violetBlue)),
                        onTap: () {
                          context.read<AddStationViewModel>().setupForEditing(place!);
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddStationView(),
                            ),
                          );
                        })
                  ])));
        });
  }
}

class ChargingPlaceTitleView extends StatelessWidget {
  ChargingPlaceTitleView({this.place});

  final ChargingPlace? place;

  @override
  Widget build(BuildContext context) {
    final place = this.place!;
    return Container(
        constraints: BoxConstraints(minHeight: 64),
        color: Colors.black12,
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(children: [
              place.score == null
                  ? Container()
                  : Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                          color: place.score!.bgColor, borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Center(
                          child: Text(place.score!.beautifulScore,
                              style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)))),
              const SizedBox(width: 8),
              Flexible(
                  child: Text(place.isHomeCharger ? "Home charger" : place.name.capitalizeEachWord,
                      maxLines: 2, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)))
            ])));
  }
}

class CheckInButton extends StatelessWidget {
  CheckInButton({this.place, required this.analyticsManager, required this.accountManager});

  ChargingPlace? place;
  AnalyticsManager analyticsManager;
  AccountManager accountManager;

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        primary: ColorPallete.violetBlue,
        minimumSize: const Size.fromHeight(50),
      ),
      onPressed: () {
        if (place != null) {
          if (accountManager.currentAccount != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                        create: (context) => CheckInViewModel(
                            place: place!, analyticsManager: analyticsManager, accountManager: accountManager),
                        child: CheckInOptionsView())));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SignInView(
                        accountManager: accountManager,
                        onSuccess: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangeNotifierProvider(
                                      create: (context) => CheckInViewModel(
                                          place: place!,
                                          analyticsManager: analyticsManager,
                                          accountManager: accountManager),
                                      child: CheckInOptionsView())));
                        })));
          }
        }
      },
      child: Text(
        l10n.checkIn,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
