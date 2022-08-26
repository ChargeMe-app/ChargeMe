import 'package:chargeme/model/charging_place/station.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

extension LatLngInit on Location {
  LatLng get latLng => LatLng(lat, lng);
}
