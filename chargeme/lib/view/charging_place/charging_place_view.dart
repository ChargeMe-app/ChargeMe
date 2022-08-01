import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/model/charging_place/charging_place.dart';
import 'package:chargeme/view/charging_place/details_view.dart';
import 'package:chargeme/view/charging_place/reviews_view.dart';
import 'package:chargeme/view/charging_place/stations_list_view.dart';
import 'package:flutter/material.dart';
import 'package:chargeme/model/charging_place/charging_place.dart' as charging_place;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChargingPlaceView extends StatefulWidget {
  const ChargingPlaceView({Key? key, this.icon}) : super(key: key);

  final BitmapDescriptor? icon;

  @override
  _ChargingPlaceView createState() => _ChargingPlaceView();
}

class _ChargingPlaceView extends State<ChargingPlaceView> {
  ChargingPlace? place;
  double scrollUpOffset = 0;
  double imageContainerHeight = 200;

  @override
  void initState() {
    super.initState();
    setupChargingPlace();
  }

  void setupChargingPlace() async {
    place = (await charging_place.getTestStation())[0];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    if (place == null) {
      return Center(child: Text(l10n.loading));
    } else {
      return Scaffold(
          appBar: AppBar(title: Text(l10n.appTitle), backgroundColor: ColorPallete.violetBlue),
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
                                CheckInButton(),
                                const SizedBox(height: 10),
                                DetailsView(
                                    latitude: place!.latitude,
                                    longitude: place!.longitude,
                                    icon: widget.icon,
                                    address: place?.address,
                                    phoneNumber: place?.phoneNumber),
                                const SizedBox(height: 10),
                                StationsListView(stations: place!.stations),
                                const SizedBox(height: 10),
                                ReviewsView(reviews: place!.reviews)
                              ]))
                        ],
                      )))));
    }
  }
}

class ChargingPlaceTitleView extends StatelessWidget {
  ChargingPlaceTitleView({required this.place});

  final ChargingPlace place;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black12,
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(children: [
              place.score == null
                  ? Container()
                  : Container(
                      width: 48,
                      height: 48,
                      decoration:
                          const BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Center(
                          child: Text(place.score!.beautifulScore,
                              style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)))),
              const SizedBox(width: 8),
              Column(children: [Text(place.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20))])
            ])));
  }
}

class CheckInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: ColorPallete.violetBlue,
        minimumSize: const Size.fromHeight(50),
      ),
      onPressed: () {},
      child: Text(
        l10n.checkIn,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}