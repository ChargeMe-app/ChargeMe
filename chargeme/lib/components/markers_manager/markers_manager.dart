import 'dart:convert';
import 'dart:io';

import 'package:chargeme/model/station_marker/station_marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MarkersManager {
  final String _baseUrl = "46.39.245.245:8080";
  final String _stationsPath = "/v1/locations";

  Future<List<StationMarker>> getStationMarkers({required LatLngBounds bounds}) async {
    final queryParameters = {
      'latitudeMin': bounds.southwest.latitude.toString(),
      'longitudeMin': bounds.southwest.longitude.toString(),
      'latitudeMax': bounds.northeast.latitude.toString(),
      'longitudeMax': bounds.northeast.longitude.toString()
    };
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    try {
      final response = await http.get(Uri.http(_baseUrl, _stationsPath, queryParameters), headers: headers);
      if (response.statusCode == 200) {
        final body = jsonDecode(utf8.decode(response.bodyBytes));

        var data = body["locations"];
        List<StationMarker> stationMarkers = List<StationMarker>.from(data
            .map(
              (dynamic item) => StationMarker.fromJson(item),
            )
            .toList());

        return stationMarkers;
      } else {
        throw "Unable to retrieve markers.";
      }
    } catch (err) {
      print(err);
      return [];
    }
  }
}
