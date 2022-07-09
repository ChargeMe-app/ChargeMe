// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_marker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationMarker _$StationMarkerFromJson(Map<String, dynamic> json) =>
    StationMarker(
      access: json['access'] as int,
      address: json['address'] as String,
      icon: json['icon'] as String?,
      icon_type: json['icon_type'] as String?,
      id: json['id'] as int,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      name: json['name'] as String,
      score: (json['score'] as num?)?.toDouble(),
      stations: (json['stations'] as List<dynamic>)
          .map((e) => MarkerStations.fromJson(e as Map<String, dynamic>))
          .toList(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$StationMarkerToJson(StationMarker instance) =>
    <String, dynamic>{
      'access': instance.access,
      'address': instance.address,
      'icon': instance.icon,
      'icon_type': instance.icon_type,
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'name': instance.name,
      'score': instance.score,
      'stations': instance.stations,
      'url': instance.url,
    };

MarkerStations _$MarkerStationsFromJson(Map<String, dynamic> json) =>
    MarkerStations(
      json['id'] as int,
      (json['outlets'] as List<dynamic>)
          .map((e) => MarkerOutlet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MarkerStationsToJson(MarkerStations instance) =>
    <String, dynamic>{
      'id': instance.id,
      'outlets': instance.outlets,
    };

MarkerOutlet _$MarkerOutletFromJson(Map<String, dynamic> json) => MarkerOutlet(
      connector: $enumDecode(_$StationTypeEnumMap, json['connector']),
      id: json['id'] as int,
      kilowatts: (json['kilowatts'] as num?)?.toDouble(),
      power: json['power'] as int?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$MarkerOutletToJson(MarkerOutlet instance) =>
    <String, dynamic>{
      'connector': _$StationTypeEnumMap[instance.connector],
      'id': instance.id,
      'kilowatts': instance.kilowatts,
      'power': instance.power,
      'status': instance.status,
    };

const _$StationTypeEnumMap = {
  StationType.type1: 2,
  StationType.chademo: 3,
  StationType.tesla: 6,
  StationType.type2: 7,
  StationType.wallEuro: 10,
  StationType.cssCombo: 13,
  StationType.threePhase: 14,
};
