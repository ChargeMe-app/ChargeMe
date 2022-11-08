import 'dart:convert';
import 'dart:io';

import 'package:chargeme/components/analytics_manager/analytics_manager.dart';
import 'package:chargeme/model/charging_place/charging_place.dart';
import 'package:chargeme/components/helpers/ip.dart';
import 'package:http/http.dart' as http;

class ChargingPlaceManager {
  final String _baseUrl = "${IP.current}";
  final String _stationsPath = "/v1/locations/stations";
  AnalyticsManager analyticsManager;

  ChargingPlaceManager({required this.analyticsManager});

  Future<ChargingPlace?> getChargingPlace({required String id}) async {
    final queryParameters = {'locationId': id};
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    try {
      final response = await http.get(Uri.http(_baseUrl, _stationsPath, queryParameters), headers: headers);
      if (response.statusCode == 200) {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        ChargingPlace place = ChargingPlace.fromJson(body);
        return place;
      } else {
        throw "Unable to get charging place";
      }
    } catch (err) {
      analyticsManager.logErrorEvent(err.toString());
      return null;
    }
  }
}
