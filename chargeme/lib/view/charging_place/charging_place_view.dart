import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/model/charging_place/charging_place.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:chargeme/view/charging_place/reviews_view.dart';
import 'package:chargeme/view/charging_place/stations_list_view.dart';
import 'package:flutter/material.dart';
import 'package:chargeme/model/charging_place/charging_place.dart' as chargingPlace;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:chargeme/extensions/string_extensions.dart';

class ChargingPlaceView extends StatefulWidget {
  const ChargingPlaceView({Key? key}) : super(key: key);

  @override
  _ChargingPlaceView createState() => _ChargingPlaceView();
}

class _ChargingPlaceView extends State<ChargingPlaceView> {
  ChargingPlace? place;

  @override
  void initState() {
    super.initState();
    setupChargingPlace();
  }

  void setupChargingPlace() async {
    place = (await chargingPlace.getTestStation())[0];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    if (place == null) {
      return Center(child: Text("Loading"));
    } else {
      return Scaffold(
          appBar: AppBar(title: Text(l10n.name), backgroundColor: ColorPallete.violetBlue),
          body: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(height: 200, color: Colors.grey),
              ChargingPlaceTitleView(place: place!),
              Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 24),
                  child: Column(children: [
                    CheckInButton(),
                    const SizedBox(height: 10),
                    DetailsView(
                        latitude: place!.latitude,
                        longitude: place!.longitude,
                        address: place?.address,
                        phoneNumber: place?.phoneNumber),
                    const SizedBox(height: 10),
                    StationsListView(stations: place!.stations),
                    const SizedBox(height: 10),
                    ReviewsView(reviews: place!.reviews)
                  ]))
            ],
          )));
    }
  }
}

class DetailsView extends StatelessWidget {
  DetailsView({required this.latitude, required this.longitude, this.address, this.phoneNumber});

  final double latitude;
  final double longitude;
  final String? address;
  final String? phoneNumber;
  LatLng get latLng => LatLng(latitude, longitude);

  @override
  Widget build(BuildContext context) {
    return BoxWithTitle(title: "Details", footer: "Get directions", children: [
      address == null ? Container() : row(Icons.location_pin, address!.capitalizeEachWord),
      const SizedBox(height: 8),
      phoneNumber == null ? Container() : row(Icons.phone_iphone, phoneNumber!),
      const SizedBox(height: 8),
      SizedBox(
          height: 100,
          child: GoogleMap(
            myLocationButtonEnabled: false,
            markers: [Marker(markerId: MarkerId("123"), position: latLng)].toSet(),
            initialCameraPosition: CameraPosition(
              target: latLng,
              zoom: 13.0,
            ),
          )),
      const SizedBox(height: 8),
    ]);
  }

  Widget row(IconData iconData, String text) {
    return Row(
        children: [Icon(iconData, size: 36), Flexible(child: Text(text, maxLines: 2, style: TextStyle(fontSize: 16)))]);
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
            padding: EdgeInsets.all(8),
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
                              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)))),
              SizedBox(width: 8),
              Column(children: [Text(place.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))])
            ])));
  }
}

class CheckInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: ColorPallete.violetBlue,
        minimumSize: const Size.fromHeight(50),
      ),
      onPressed: () {},
      child: const Text(
        'Check In',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
