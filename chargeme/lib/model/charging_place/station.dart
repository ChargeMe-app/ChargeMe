import 'package:json_annotation/json_annotation.dart';

part 'station.g.dart';

// TODO: Convert to snake_case!

@JsonSerializable()
class Station {
  int id;
  int locationId;
  int available;
  int cost;
  List<Outlet> outlets;
  String? name;
  String? manufacturer;
  String? costDescription;
  String? hours;
  double? kilowawtts;

  Station(
      {required this.id,
      required this.locationId,
      required this.available,
      required this.cost,
      required this.outlets,
      this.name,
      this.manufacturer,
      this.costDescription,
      this.hours,
      this.kilowawtts});

  factory Station.fromJson(Map<String, dynamic> json) => _$StationFromJson(json);
  Map<String, dynamic> toJson() => _$StationToJson(this);
}

// class Location {
//   double lat;
//   double lng;

//   Location({
//     required this.lat,
//     required this.lng,
//   });
// }

// class Cost {
//   bool isFeeRequired;
//   String description;

//   Cost({
//     required this.isFeeRequired,
//     required this.description,
//   });
// }

// class Hours {
//   bool isAlwaysOpened;
//   String description;

//   Hours({
//     required this.isAlwaysOpened,
//     required this.description,
//   });
// }

@JsonSerializable()
class Outlet {
  int id;
  int available;
  ConnectorType connectorType;
  double? kilowatts;
  String? description;

  Outlet({required this.id, required this.available, required this.connectorType, this.kilowatts, this.description});

  factory Outlet.fromJson(Map<String, dynamic> json) => _$OutletFromJson(json);
  Map<String, dynamic> toJson() => _$OutletToJson(this);
}

enum VehicleType {
  @JsonValue(4)
  teslaModelS
}

enum ConnectorType {
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

extension MyEnumExtension on ConnectorType {
  String get str {
    switch (this) {
      case ConnectorType.wall:
        return "Wall";
      case ConnectorType.type1:
        return "J-1772";
      case ConnectorType.chademo:
        return "CHAdeMO";
      case ConnectorType.teslaRoadster:
        return "Tesla (Roadster)";
      case ConnectorType.nema1450:
        return "NEMA 14-50";
      case ConnectorType.tesla:
        return "Tesla";
      case ConnectorType.type2:
        return "Type 2";
      case ConnectorType.wallEuro:
        return "Wall (euro)";
      case ConnectorType.commando:
        return "Commando";
      case ConnectorType.cssCombo:
        return "CCS/SAE";
      case ConnectorType.threePhase:
        return "Three Phase";
      case ConnectorType.caravanMainsSocket:
        return "Caravan Mains Socket";
      case ConnectorType.gbt:
        return "GB/T";
      case ConnectorType.type3a:
        return "Type 3A";
    }
  }
}

enum Access { public, restrictes }

enum AmenityType { lodging, dining, restrooms, evParking, valetParking, park, wifi, shopping, grocery, hiking, camping }

@JsonSerializable()
class Amenity {
  int locationId;
  // AmenityType type;
  int type;

  Amenity({required this.locationId, required this.type});

  factory Amenity.fromJson(Map<String, dynamic> json) => _$AmenityFromJson(json);
  Map<String, dynamic> toJson() => _$AmenityToJson(this);
}
