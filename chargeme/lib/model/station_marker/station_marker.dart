import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:chargeme/gen/assets.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/services.dart' show rootBundle;

part 'station_marker.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class StationMarker {
  int access;
  String address;
  String? icon;
  IconType iconType;
  String id;
  double latitude;
  double longitude;
  String name;
  double? score;
  List<MarkerStation> stations;
  String? url;

  StationMarker(
      {required this.access,
      required this.address,
      this.icon,
      required this.iconType,
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
class MarkerStation {
  String id;
  List<MarkerOutlet> outlets;

  MarkerStation(this.id, this.outlets);

  factory MarkerStation.fromJson(Map<String, dynamic> json) => _$MarkerStationFromJson(json);
  Map<String, dynamic> toJson() => _$MarkerStationToJson(this);
}

@JsonSerializable()
class MarkerOutlet {
  ConnectorType connector;
  String id;
  double? kilowatts;
  int? power;
  String? status;

  MarkerOutlet({required this.connector, required this.id, this.kilowatts, this.power, this.status});

  factory MarkerOutlet.fromJson(Map<String, dynamic> json) => _$MarkerOutletFromJson(json);
  Map<String, dynamic> toJson() => _$MarkerOutletToJson(this);
}

enum IconType {
  @JsonValue("G")
  publicStandard,
  @JsonValue("GR")
  repairStandard,
  @JsonValue("Y")
  publicFast,
  @JsonValue("YR")
  repairFast,
  @JsonValue("H")
  home,
  @JsonValue("B")
  restricted,
}

extension MarkerIcon on IconType {
  String get assetPath {
    switch (this) {
      case IconType.publicStandard:
        return Asset.publicStandard64.path;
      case IconType.repairStandard:
        return Asset.inRepair64.path;
      case IconType.publicFast:
        return Asset.publicFast64.path;
      case IconType.repairFast:
        return Asset.inRepair64.path;
      case IconType.home:
        return Asset.home64.path;
      case IconType.restricted:
        return Asset.publicGrey64.path;
    }
  }

  Future<BitmapDescriptor?> getMarkerIcon() async {
    final Uint8List? mapMarkerBytes = await getBytesFromAsset(assetPath, 86);
    if (mapMarkerBytes != null) {
      return BitmapDescriptor.fromBytes(mapMarkerBytes);
    }
    return null;
  }
}

Future<Uint8List?> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List();
}

Future<List<StationMarker>> getTestStationMarkers() async {
  List<StationMarker> stations;
  var response = await rootBundle.loadString('assets/temporary/test_markers.json');

  stations = (json.decode(response) as List).map((i) => StationMarker.fromJson(i)).toList();
  return stations;
}
