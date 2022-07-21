// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Station _$StationFromJson(Map<String, dynamic> json) => Station(
      id: json['id'] as int,
      locationId: json['location_id'] as int,
      available: json['available'] as int,
      cost: json['cost'] as int,
      outlets: (json['outlets'] as List<dynamic>)
          .map((e) => Outlet.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
      manufacturer: json['manufacturer'] as String?,
      costDescription: json['cost_description'] as String?,
      hours: json['hours'] as String?,
      kilowawtts: (json['kilowawtts'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StationToJson(Station instance) => <String, dynamic>{
      'id': instance.id,
      'location_id': instance.locationId,
      'available': instance.available,
      'cost': instance.cost,
      'outlets': instance.outlets,
      'name': instance.name,
      'manufacturer': instance.manufacturer,
      'cost_description': instance.costDescription,
      'hours': instance.hours,
      'kilowawtts': instance.kilowawtts,
    };

Outlet _$OutletFromJson(Map<String, dynamic> json) => Outlet(
      id: json['id'] as int,
      available: json['available'] as int,
      connectorType:
          $enumDecode(_$ConnectorTypeEnumMap, json['connector_type']),
      kilowatts: (json['kilowatts'] as num?)?.toDouble(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$OutletToJson(Outlet instance) => <String, dynamic>{
      'id': instance.id,
      'available': instance.available,
      'connector_type': _$ConnectorTypeEnumMap[instance.connectorType],
      'kilowatts': instance.kilowatts,
      'description': instance.description,
    };

const _$ConnectorTypeEnumMap = {
  ConnectorType.wall: 1,
  ConnectorType.type1: 2,
  ConnectorType.chademo: 3,
  ConnectorType.teslaRoadster: 4,
  ConnectorType.nema1450: 5,
  ConnectorType.tesla: 6,
  ConnectorType.type2: 7,
  ConnectorType.wallEuro: 10,
  ConnectorType.commando: 11,
  ConnectorType.cssCombo: 13,
  ConnectorType.threePhase: 14,
  ConnectorType.caravanMainsSocket: 15,
  ConnectorType.gbt: 16,
  ConnectorType.type3a: 24,
};

Amenity _$AmenityFromJson(Map<String, dynamic> json) => Amenity(
      locationId: json['location_id'] as int,
      type: json['type'] as int,
    );

Map<String, dynamic> _$AmenityToJson(Amenity instance) => <String, dynamic>{
      'location_id': instance.locationId,
      'type': instance.type,
    };
