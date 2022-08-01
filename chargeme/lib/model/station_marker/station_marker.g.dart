// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_marker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationMarker _$StationMarkerFromJson(Map<String, dynamic> json) => StationMarker(
      access: json['access'] as int,
      address: json['address'] as String,
      icon: json['icon'] as String?,
      iconType: $enumDecode(_$IconTypeEnumMap, json['icon_type']),
      id: json['id'] as int,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      name: json['name'] as String,
      score: (json['score'] as num?)?.toDouble(),
      stations:
          (json['stations'] as List<dynamic>).map((e) => MarkerStation.fromJson(e as Map<String, dynamic>)).toList(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$StationMarkerToJson(StationMarker instance) => <String, dynamic>{
      'access': instance.access,
      'address': instance.address,
      'icon': instance.icon,
      'icon_type': _$IconTypeEnumMap[instance.iconType],
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'name': instance.name,
      'score': instance.score,
      'stations': instance.stations,
      'url': instance.url,
    };

const _$IconTypeEnumMap = {
  IconType.publicStandard: 'G',
  IconType.repairStandard: 'GR',
  IconType.publicFast: 'Y',
  IconType.repairFast: 'YR',
};

MarkerStation _$MarkerStationFromJson(Map<String, dynamic> json) => MarkerStation(
      json['id'] as int,
      (json['outlets'] as List<dynamic>).map((e) => MarkerOutlet.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$MarkerStationToJson(MarkerStation instance) => <String, dynamic>{
      'id': instance.id,
      'outlets': instance.outlets,
    };

MarkerOutlet _$MarkerOutletFromJson(Map<String, dynamic> json) => MarkerOutlet(
      connector: $enumDecode(_$ConnectorTypeEnumMap, json['connector']),
      id: json['id'] as int,
      kilowatts: (json['kilowatts'] as num?)?.toDouble(),
      power: json['power'] as int?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$MarkerOutletToJson(MarkerOutlet instance) => <String, dynamic>{
      'connector': _$ConnectorTypeEnumMap[instance.connector],
      'id': instance.id,
      'kilowatts': instance.kilowatts,
      'power': instance.power,
      'status': instance.status,
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
