import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/gen/l10n.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:chargeme/extensions/placemark_extensions.dart';

class ChooseLocationView extends StatefulWidget {
  final Function(String?, LatLng) onLocationChosen;
  final LatLng? initialMarkerPosition;

  const ChooseLocationView({required this.onLocationChosen, this.initialMarkerPosition, Key? key}) : super(key: key);

  @override
  _ChooseLocationView createState() => _ChooseLocationView();
}

class _ChooseLocationView extends State<ChooseLocationView> {
  final LatLng _center = const LatLng(55.7558, 37.6173);
  String _hintText = L10n.longTapOnMapToPlaceAMarker.str;
  Marker? _marker;
  String? fullAddress;

  @override
  void initState() {
    super.initState();
    if (widget.initialMarkerPosition != null) {
      setState(() {
        _marker = Marker(markerId: const MarkerId("targetLocation"), position: widget.initialMarkerPosition!);
      });
    }
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final Position userLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    controller.animateCamera(CameraUpdate.newLatLng(LatLng(userLocation.latitude, userLocation.longitude)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(L10n.chooseLocation.str),
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
                _marker = Marker(markerId: const MarkerId("targetLocation"), position: latLng);
                setState(() {});
                try {
                  List<Placemark> placemarks =
                      await placemarkFromCoordinates(latLng.latitude, latLng.longitude, localeIdentifier: "ru_RU");
                  print(placemarks);
                  if (placemarks.isNotEmpty) {
                    final place = placemarks.first;
                    fullAddress = place.fullAddress;
                  }
                } catch (error) {
                  print(error);
                }
                widget.onLocationChosen(fullAddress, latLng);
                setState(() {
                  _hintText = L10n.locationIsSuccessfullySet.str;
                });
              }),
          Container(
              color: Colors.black45,
              child: Row(children: [
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(_hintText,
                        maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white))),
                const Spacer()
              ]))
        ]));
  }
}
