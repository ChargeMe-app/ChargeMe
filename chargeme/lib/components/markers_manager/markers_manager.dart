import 'dart:convert';
import 'dart:io';

import 'package:chargeme/components/analytics_manager/analytics_manager.dart';
import 'package:chargeme/model/station_marker/station_marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:chargeme/components/helpers/ip.dart';
import 'package:http/http.dart' as http;

class MarkersManager {
  final String _stationsPath = "/v1/locations";
  final AnalyticsManager analyticsManager;

  MarkersManager({required this.analyticsManager});

  Future<List<StationMarker>> getStationMarkers({required LatLngBounds bounds}) async {
    final queryParameters = {
      'latitudeMin': bounds.southwest.latitude.toString(),
      'longitudeMin': bounds.southwest.longitude.toString(),
      'latitudeMax': bounds.northeast.latitude.toString(),
      'longitudeMax': bounds.northeast.longitude.toString()
    };
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    analyticsManager.logEvent("get_markers", params: queryParameters);

    try {
      final response = await http.get(Uri.http(IP.current, _stationsPath, queryParameters), headers: headers);
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
      analyticsManager.logErrorEvent(err.toString());
      return [];
    }
  }
}
