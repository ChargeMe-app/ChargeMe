import 'package:json_annotation/json_annotation.dart';

part 'station.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
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

class Location {
  double lat;
  double lng;

  Location({
    required this.lat,
    required this.lng,
  });
}

@JsonSerializable(fieldRename: FieldRename.snake)
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

@JsonSerializable(fieldRename: FieldRename.snake)
class Amenity {
  int locationId;
  // AmenityType type;
  int type;

  Amenity({required this.locationId, required this.type});

  factory Amenity.fromJson(Map<String, dynamic> json) => _$AmenityFromJson(json);
  Map<String, dynamic> toJson() => _$AmenityToJson(this);
}

enum VehicleType { teslaModelS }

enum ConnectorType {
  @JsonValue(0)
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

extension StringConnectorTypeExtension on ConnectorType {
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

extension IconConnectorTypeExtension on ConnectorType {
  String get iconPath {
    switch (this) {
      case ConnectorType.wall:
        return "assets/icons/plugs/wall.png";
      case ConnectorType.type1:
        return "assets/icons/plugs/j1772.png";
      case ConnectorType.chademo:
        return "assets/icons/plugs/chademo.png";
      case ConnectorType.teslaRoadster:
        return "assets/icons/plugs/teslaRoadster.png";
      case ConnectorType.nema1450:
        return "assets/icons/plugs/nema1450.png";
      case ConnectorType.tesla:
        return "assets/icons/plugs/teslaRoadster.png";
      case ConnectorType.type2:
        return "assets/icons/plugs/type2.png";
      case ConnectorType.wallEuro:
        return "assets/icons/plugs/wallEuro.png";
      case ConnectorType.commando:
        return "assets/icons/plugs/commando3pin.png";
      case ConnectorType.cssCombo:
        return "assets/icons/plugs/css.png";
      case ConnectorType.threePhase:
        return "assets/icons/plugs/threePhase.png";
      case ConnectorType.caravanMainsSocket:
        return "assets/icons/plugs/caravanMainSocket.png";
      case ConnectorType.gbt:
        return "assets/icons/plugs/type2.png";
      case ConnectorType.type3a:
        return "assets/icons/plugs/type3.png";
    }
  }
}

enum Access { public, restrictes }

enum AmenityType { lodging, dining, restrooms, evParking, valetParking, park, wifi, shopping, grocery, hiking, camping }
