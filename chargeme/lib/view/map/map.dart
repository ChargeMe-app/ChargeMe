import 'package:chargeme/components/helpers/throttler.dart';
import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:chargeme/view/map/loading_view.dart';
import 'package:chargeme/view/map/marker_info_view.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:chargeme/model/station_marker/station_marker.dart';
import '../../model/charging_place/charging_place.dart' as charging_place;
import 'package:chargeme/components/markers_manager/markers_manager.dart' as markers_manager;

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
  final _manager = markers_manager.MarkersManager();
  final Throttler _throttler = Throttler();
  var isLoading = false;
  Map<IconType, BitmapDescriptor> _cachedMarkerIcons = {};

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    _setupCachedMarkerIcons();
  }

  Future<void> _setupCachedMarkerIcons() async {
    for (var v in IconType.values) {
      final icon = await v.getMarkerIcon();
      if (icon != null) {
        _cachedMarkerIcons[v] = icon;
      }
    }
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _customInfoWindowController.googleMapController = controller;
    final Position userLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    controller.animateCamera(CameraUpdate.newLatLng(LatLng(userLocation.latitude, userLocation.longitude)));
  }

  Future<void> _updateMarkers(LatLngBounds region) async {
    final stationMarkers = await _manager.getStationMarkers(bounds: region);

    _markers.clear();
    for (final stationMarker in stationMarkers) {
      String stationTypes =
          stationMarker.stations.map((e) => e.outlets.map((e) => e.connector.str).join(", ")).join(", ");
      LatLng latLng = LatLng(stationMarker.latitude, stationMarker.longitude);
      var markerIcon = _cachedMarkerIcons[stationMarker.iconType];
      final marker = Marker(
          consumeTapEvents: true,
          icon: markerIcon ?? BitmapDescriptor.defaultMarker,
          markerId: MarkerId(stationMarker.id.toString()),
          position: LatLng(stationMarker.latitude, stationMarker.longitude),
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
                MarkerInfoView(stationMarker.id, stationMarker.name, stationTypes, markerIcon, stationMarker.score),
                latLng);
          });
      _markers[stationMarker.id.toString()] = marker;
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
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
          _markers["123"] = Marker(
              consumeTapEvents: true,
              markerId: MarkerId("123"),
              position: latLng,
              onTap: () {
                _customInfoWindowController.addInfoWindow!(
                    MarkerInfoView("213995", "Station #1", "Cool station", null, 8.6), latLng);
              });
          setState(() {});
        },
        onTap: (position) {
          _customInfoWindowController.hideInfoWindow!();
        },
        onCameraMove: (CameraPosition position) async {
          _customInfoWindowController.onCameraMove!();

          if (_customInfoWindowController.googleMapController != null) {
            _throttler.throttle(const Duration(milliseconds: 500), () async {
              final LatLngBounds region = await _customInfoWindowController.googleMapController!.getVisibleRegion();
              print(region.toString());
              _updateMarkers(region);
              setState(() {
                isLoading = true;
              });
            });
          }
        },
      ),
      CustomInfoWindow(
        controller: _customInfoWindowController,
        height: 60,
        width: 250,
        offset: 48,
      ),
      isLoading ? LoadingView() : Container()
    ]);
  }
}
