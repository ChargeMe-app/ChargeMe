import 'package:json_annotation/json_annotation.dart';

class Station {
  String name;
  String? description;
  String? phoneNumber;
  String? address;
  Location location;
  List<StationType> stationTypes;
  Access? access;
  Cost? cost;
  Hours? hours;
  Amenities? amenities;
  bool isOpenOrActive;

  Station(
      {required this.name,
      this.description,
      this.phoneNumber,
      this.address,
      required this.location,
      required this.stationTypes,
      this.access,
      this.cost,
      this.hours,
      this.amenities,
      required this.isOpenOrActive});

  // factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  // Map<String, dynamic> toJson() => _$LatLngToJson(this);
}

class Location {
  double lat;
  double lng;

  Location({
    required this.lat,
    required this.lng,
  });
}

class Cost {
  bool isFeeRequired;
  String description;

  Cost({
    required this.isFeeRequired,
    required this.description,
  });
}

class Hours {
  bool isAlwaysOpened;
  String description;

  Hours({
    required this.isAlwaysOpened,
    required this.description,
  });
}

enum StationType {
  @JsonValue(1)
  wall,
  @JsonValue(2)
  type1,
  @JsonValue(3)
  chademo,
  @JsonValue(4)
  teslaRoadster,
  @JsonValue(5)
  nema1450,
  @JsonValue(6)
  tesla,
  @JsonValue(7)
  type2,
  @JsonValue(10)
  wallEuro,
  @JsonValue(11)
  commando,
  @JsonValue(13)
  cssCombo,
  @JsonValue(14)
  threePhase,
  @JsonValue(15)
  caravanMainsSocket,
  @JsonValue(16)
  gbt,
  @JsonValue(24)
  type3a
}

extension MyEnumExtension on StationType {
  String get str {
    switch (this) {
      case StationType.wall:
        return "Wall";
      case StationType.type1:
        return "J-1772";
      case StationType.chademo:
        return "CHAdeMO";
      case StationType.teslaRoadster:
        return "Tesla (Roadster)";
      case StationType.nema1450:
        return "NEMA 14-50";
      case StationType.tesla:
        return "Tesla";
      case StationType.type2:
        return "Type 2";
      case StationType.wallEuro:
        return "Wall (euro)";
      case StationType.commando:
        return "Commando";
      case StationType.cssCombo:
        return "CCS/SAE";
      case StationType.threePhase:
        return "Three Phase";
      case StationType.caravanMainsSocket:
        return "Caravan Mains Socket";
      case StationType.gbt:
        return "GB/T";
      case StationType.type3a:
        return "Type 3A";
    }
  }
}

enum Access { public, restrictes }

enum Amenities { lodging, dining, restrooms, evParking, valetParking, park, wifi, shopping, grocery, hiking, camping }
