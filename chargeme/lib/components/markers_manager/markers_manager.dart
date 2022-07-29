import 'dart:convert';

import 'package:chargeme/model/station_marker/station_marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MarkersManager {
  Future<List<StationMarker>> getStationMarkers({required LatLngBounds bounds}) async {
    var response = await http.get(Uri.parse(""));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<StationMarker> stationMarkers = body
          .map(
            (dynamic item) => StationMarker.fromJson(item),
          )
          .toList();

      return stationMarkers;
    } else {
      throw "Unable to retrieve markers.";
    }
  }
}
