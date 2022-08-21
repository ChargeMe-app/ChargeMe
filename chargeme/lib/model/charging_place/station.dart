import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'station.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Station {
  String id;
  String? locationId;
  int? available;
  int? cost;
  List<Outlet> outlets;
  String? name;
  String? manufacturer;
  String? costDescription;
  String? hours;
  double? kilowatts;

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
      this.kilowatts});

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
  String id;
  int? available;
  @JsonKey(name: "connector")
  ConnectorType connectorType;
  double? kilowatts;
  String? description;

  Outlet({required this.id, this.available, required this.connectorType, this.kilowatts, this.description});

  factory Outlet.fromJson(Map<String, dynamic> json) => _$OutletFromJson(json);
  Map<String, dynamic> toJson() => _$OutletToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Amenity {
  String locationId;
  AmenityType form;

  Amenity({required this.locationId, required this.form});

  factory Amenity.fromJson(Map<String, dynamic> json) => _$AmenityFromJson(json);
  Map<String, dynamic> toJson() => _$AmenityToJson(this);
}

enum VehicleType { teslaModelS }

enum ConnectorType {
  @JsonValue(0)
  unknown,
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
  @JsonValue(8)
  type3,
  @JsonValue(9)
  wallBS1363,
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
      case ConnectorType.unknown:
        return "Unknown";
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
      case ConnectorType.type3:
        return "Type 3";
      case ConnectorType.wallBS1363:
        return "Wall (BS1363)";
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
      case ConnectorType.unknown:
        return "assets/icons/plugs/commando3pin.png";
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
      case ConnectorType.type3:
        return "assets/icons/plugs/type3.png";
      case ConnectorType.wallBS1363:
        return "assets/icons/plugs/wall.png";
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

enum Access { public, restricted }

enum AmenityType {
  @JsonValue(0)
  lodging,
  @JsonValue(1)
  dining,
  @JsonValue(2)
  restrooms,
  @JsonValue(3)
  evParking,
  @JsonValue(4)
  valetParking,
  @JsonValue(5)
  park,
  @JsonValue(6)
  wifi,
  @JsonValue(7)
  shopping,
  @JsonValue(8)
  grocery,
  @JsonValue(9)
  hiking,
  @JsonValue(10)
  camping
}

extension AmenityTitle on AmenityType {
  String localizedTitle(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    switch (this) {
      case AmenityType.lodging:
        return l10n.lodging;
      case AmenityType.dining:
        return l10n.dining;
      case AmenityType.restrooms:
        return l10n.restrooms;
      case AmenityType.evParking:
        return l10n.evParking;
      case AmenityType.valetParking:
        return l10n.valetParking;
      case AmenityType.park:
        return l10n.park;
      case AmenityType.wifi:
        return l10n.wifi;
      case AmenityType.shopping:
        return l10n.shopping;
      case AmenityType.grocery:
        return l10n.grocery;
      case AmenityType.hiking:
        return l10n.hiking;
      case AmenityType.camping:
        return l10n.camping;
    }
  }
}

extension AmenityIcon on AmenityType {
  String get icon {
    switch (this) {
      case AmenityType.lodging:
        return "assets/icons/amenities/lodging.png";
      case AmenityType.dining:
        return "assets/icons/amenities/dining.png";
      case AmenityType.restrooms:
        return "assets/icons/amenities/WC.png";
      case AmenityType.evParking:
        return "assets/icons/amenities/evParking.png";
      case AmenityType.valetParking:
        return "assets/icons/amenities/valetParking.png";
      case AmenityType.park:
        return "assets/icons/amenities/park.png";
      case AmenityType.wifi:
        return "assets/icons/amenities/wifi.png";
      case AmenityType.shopping:
        return "assets/icons/amenities/shopping.png";
      case AmenityType.grocery:
        return "assets/icons/amenities/grocery.png";
      case AmenityType.hiking:
        return "assets/icons/amenities/hiking.png";
      case AmenityType.camping:
        return "assets/icons/amenities/camping.png";
    }
  }
}
