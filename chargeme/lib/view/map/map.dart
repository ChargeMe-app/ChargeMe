import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:chargeme/view/map/marker_info_view.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import '../../src/locations.dart' as locations;
import '../../model/station_marker/station_marker.dart' as stationMarker;

class GMap extends StatefulWidget {
  const GMap({Key? key}) : super(key: key);

  @override
  _GMap createState() => _GMap();
}

class _GMap extends State<GMap> {
  late GoogleMapController mapController;
  final CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();

  final LatLng _center = const LatLng(55.7558, 37.6173);
  final Map<String, Marker> _markers = {};

  BitmapDescriptor mapMarker = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    super.initState();
    setMapMarker();
  }

  void setMapMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), "assets/icons/mapMarker.png");
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    // mapController = controller;
    final stationMarkers = await stationMarker.getTestStationMarkers();
    _customInfoWindowController.googleMapController = controller;
    final Position userLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    controller.animateCamera(CameraUpdate.newLatLng(LatLng(userLocation.latitude, userLocation.longitude)));
    setState(() {
      _markers.clear();
      for (final stationMarker in stationMarkers) {
        String stationTypes =
            stationMarker.stations.map((e) => e.outlets.map((e) => e.connector.str).join(", ")).join(", ");
        LatLng latLng = LatLng(stationMarker.latitude, stationMarker.longitude);
        final marker = Marker(
            consumeTapEvents: true,
            markerId: MarkerId(stationMarker.id.toString()),
            position: LatLng(stationMarker.latitude, stationMarker.longitude),
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                  MarkerInfoView(stationMarker.name, stationTypes, stationMarker.score), latLng);
            });
        _markers[stationMarker.id.toString()] = marker;
      }
    });
  }

  Widget build(BuildContext context) {
    return Stack(children: [
      GoogleMap(
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: _markers.values.toSet(),
        onLongPress: (LatLng latLng) {
          setState(() {
            _markers["123"] = Marker(
                consumeTapEvents: true,
                icon: mapMarker,
                markerId: MarkerId("123"),
                position: latLng,
                onTap: () {
                  _customInfoWindowController.addInfoWindow!(MarkerInfoView("Station #1", "Cool station", 8.6), latLng);
                });
          });
        },
        onTap: (position) {
          _customInfoWindowController.hideInfoWindow!();
        },
        onCameraMove: (CameraPosition position) async {
          _customInfoWindowController.onCameraMove!();

          // final LatLngBounds region = await mapController.getVisibleRegion();
          // print(region.toString());
          // send region to server to get pins
        },
      ),
      CustomInfoWindow(
        controller: _customInfoWindowController,
        height: 60,
        width: 250,
        offset: 25,
      )
    ]);
  }
}
