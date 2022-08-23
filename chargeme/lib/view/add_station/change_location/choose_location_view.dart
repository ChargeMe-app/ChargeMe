import 'package:chargeme/extensions/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class ChooseLocationView extends StatefulWidget {
  final Function(String?, LatLng) onLocationChosen;

  const ChooseLocationView({required this.onLocationChosen, Key? key}) : super(key: key);

  @override
  _ChooseLocationView createState() => _ChooseLocationView();
}

class _ChooseLocationView extends State<ChooseLocationView> {
  final LatLng _center = const LatLng(55.7558, 37.6173);
  Marker? _marker;
  String? fullAddress;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final Position userLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    controller.animateCamera(CameraUpdate.newLatLng(LatLng(userLocation.latitude, userLocation.longitude)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Choose location"),
          backgroundColor: ColorPallete.violetBlue,
        ),
        body: Stack(children: [
          GoogleMap(
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              markers: _marker != null ? [_marker!].toSet() : Set(),
              onLongPress: (LatLng latLng) async {
                fullAddress = null;
                _marker = Marker(markerId: MarkerId("targetLocation"), position: latLng);
                setState(() {});
                try {
                  List<Placemark> placemarks =
                      await placemarkFromCoordinates(latLng.latitude, latLng.longitude, localeIdentifier: "ru_RU");
                  print(placemarks);
                  if (placemarks.isNotEmpty) {
                    final place = placemarks.first;
                    fullAddress = "${place.street} ${place.locality} ${place.subLocality}, ${place.country}";
                  }
                } catch (error) {
                  print(error);
                }
                widget.onLocationChosen(fullAddress, latLng);
              }),
          Container(
              color: Colors.black45,
              child: Row(children: const [
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("Long tap on map to place a marker", style: TextStyle(color: Colors.white))),
                Spacer()
              ]))
        ]));
  }
}
