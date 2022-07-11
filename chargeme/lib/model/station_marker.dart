import 'dart:convert';
import 'dart:ffi';

import 'package:chargeme/model/Station.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/services.dart' show rootBundle;

part 'station_marker.g.dart';

@JsonSerializable()
class StationMarker {
  int access;
  String address;
  String? icon;
  String? icon_type;
  int id;
  double latitude;
  double longitude;
  String name;
  double? score;
  List<MarkerStations> stations;
  String? url;

  StationMarker(
      {required this.access,
      required this.address,
      this.icon,
      this.icon_type,
      required this.id,
      required this.latitude,
      required this.longitude,
      required this.name,
      this.score,
      required this.stations,
      this.url});

  factory StationMarker.fromJson(Map<String, dynamic> json) => _$StationMarkerFromJson(json);
  Map<String, dynamic> toJson() => _$StationMarkerToJson(this);
}

@JsonSerializable()
class MarkerStations {
  int id;
  List<MarkerOutlet> outlets;

  MarkerStations(this.id, this.outlets);

  factory MarkerStations.fromJson(Map<String, dynamic> json) => _$MarkerStationsFromJson(json);
  Map<String, dynamic> toJson() => _$MarkerStationsToJson(this);
}

@JsonSerializable()
class MarkerOutlet {
  StationType connector;
  int id;
  double? kilowatts;
  int? power;
  String? status;

  MarkerOutlet({required this.connector, required this.id, this.kilowatts, this.power, this.status});

  factory MarkerOutlet.fromJson(Map<String, dynamic> json) => _$MarkerOutletFromJson(json);
  Map<String, dynamic> toJson() => _$MarkerOutletToJson(this);
}

Future<List<StationMarker>> getTestStationMarkers() async {
  List<StationMarker> stations;
  var response = await rootBundle.loadString('assets/test_markers.json');

  stations = (json.decode(response) as List).map((i) => StationMarker.fromJson(i)).toList();
  return stations;
}
