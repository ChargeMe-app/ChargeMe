// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Station _$StationFromJson(Map<String, dynamic> json) => Station(
      id: json['id'] as String,
      locationId: json['location_id'] as String?,
      available: json['available'] as int?,
      cost: json['cost'] as int?,
      outlets: (json['outlets'] as List<dynamic>)
          .map((e) => Outlet.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
      manufacturer: json['manufacturer'] as String?,
      costDescription: json['cost_description'] as String?,
      hours: json['hours'] as String?,
      kilowatts: (json['kilowatts'] as num?)?.toDouble(),
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
      'kilowatts': instance.kilowatts,
    };

Outlet _$OutletFromJson(Map<String, dynamic> json) => Outlet(
      id: json['id'] as String,
      available: json['available'] as int?,
      connectorType: $enumDecode(_$ConnectorTypeEnumMap, json['connector']),
      kilowatts: (json['kilowatts'] as num?)?.toDouble(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$OutletToJson(Outlet instance) => <String, dynamic>{
      'id': instance.id,
      'available': instance.available,
      'connector': _$ConnectorTypeEnumMap[instance.connectorType]!,
      'kilowatts': instance.kilowatts,
      'description': instance.description,
    };

const _$ConnectorTypeEnumMap = {
  ConnectorType.unknown: 0,
  ConnectorType.wall: 1,
  ConnectorType.type1: 2,
  ConnectorType.chademo: 3,
  ConnectorType.teslaRoadster: 4,
  ConnectorType.nema1450: 5,
  ConnectorType.tesla: 6,
  ConnectorType.type2: 7,
  ConnectorType.type3: 8,
  ConnectorType.wallBS1363: 9,
  ConnectorType.wallEuro: 10,
  ConnectorType.commando: 11,
  ConnectorType.cssCombo: 13,
  ConnectorType.threePhase: 14,
  ConnectorType.caravanMainsSocket: 15,
  ConnectorType.gbt: 16,
  ConnectorType.type3a: 24,
};

Amenity _$AmenityFromJson(Map<String, dynamic> json) => Amenity(
      locationId: json['location_id'] as String,
      form: $enumDecode(_$AmenityTypeEnumMap, json['form']),
    );

Map<String, dynamic> _$AmenityToJson(Amenity instance) => <String, dynamic>{
      'location_id': instance.locationId,
      'form': _$AmenityTypeEnumMap[instance.form]!,
    };

const _$AmenityTypeEnumMap = {
  AmenityType.lodging: 0,
  AmenityType.dining: 1,
  AmenityType.restrooms: 2,
  AmenityType.evParking: 3,
  AmenityType.valetParking: 4,
  AmenityType.park: 5,
  AmenityType.wifi: 6,
  AmenityType.shopping: 7,
  AmenityType.grocery: 8,
  AmenityType.hiking: 9,
  AmenityType.camping: 10,
};
