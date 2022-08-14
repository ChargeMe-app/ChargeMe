// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charging_place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargingPlace _$ChargingPlaceFromJson(Map<String, dynamic> json) =>
    ChargingPlace(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      phoneNumber: json['phone_number'] as String?,
      address: json['address'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      access: json['access'] as int?,
      accessRestriction: json['access_restriction'] as String?,
      accessRestrictionDescription:
          json['access_restriction_description'] as String?,
      accessRestrictions: (json['access_restrictions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      cost: json['cost'] as bool?,
      costDescription: json['cost_description'] as String?,
      hours: json['hours'] as String?,
      open247: json['open247'] as bool?,
      amenities: (json['amenities'] as List<dynamic>?)
          ?.map((e) => Amenity.fromJson(e as Map<String, dynamic>))
          .toList(),
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => Photo.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      stations: (json['stations'] as List<dynamic>)
          .map((e) => Station.fromJson(e as Map<String, dynamic>))
          .toList(),
      score: (json['score'] as num?)?.toDouble(),
      totalPhotos: json['total_photos'] as int?,
      totalReviews: json['total_reviews'] as int?,
    );

Map<String, dynamic> _$ChargingPlaceToJson(ChargingPlace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'phone_number': instance.phoneNumber,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'access': instance.access,
      'access_restriction': instance.accessRestriction,
      'access_restriction_description': instance.accessRestrictionDescription,
      'access_restrictions': instance.accessRestrictions,
      'cost': instance.cost,
      'cost_description': instance.costDescription,
      'hours': instance.hours,
      'open247': instance.open247,
      'amenities': instance.amenities,
      'photos': instance.photos,
      'reviews': instance.reviews,
      'stations': instance.stations,
      'score': instance.score,
      'total_photos': instance.totalPhotos,
      'total_reviews': instance.totalReviews,
    };

Photo _$PhotoFromJson(Map<String, dynamic> json) => Photo(
      caption: json['caption'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      id: json['id'] as String,
      url: Uri.parse(json['url'] as String),
      userId: json['user_id'] as String,
    );

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'caption': instance.caption,
      'created_at': instance.createdAt.toIso8601String(),
      'id': instance.id,
      'url': instance.url.toString(),
      'user_id': instance.userId,
    };

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      comment: json['comment'] as String,
      connectorType:
          $enumDecodeNullable(_$ConnectorTypeEnumMap, json['connector_type']),
      createdAt: DateTime.parse(json['created_at'] as String),
      id: json['id'] as String,
      outletId: json['outlet_id'] as String?,
      stationId: json['station_id'] as String?,
      rating: $enumDecode(_$RatingEnumMap, json['rating']),
      vehicleName: json['vehicle_name'] as String?,
      vehicleType: $enumDecodeNullable(
          _$VehicleTypeEnumMap, json['vehicle_type'],
          unknownValue: VehicleType.teslaModelS),
      userName: json['user_name'] as String?,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'comment': instance.comment,
      'connector_type': _$ConnectorTypeEnumMap[instance.connectorType],
      'created_at': instance.createdAt.toIso8601String(),
      'id': instance.id,
      'outlet_id': instance.outletId,
      'station_id': instance.stationId,
      'rating': _$RatingEnumMap[instance.rating],
      'vehicle_name': instance.vehicleName,
      'vehicle_type': _$VehicleTypeEnumMap[instance.vehicleType],
      'user_name': instance.userName,
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

const _$RatingEnumMap = {
  Rating.negative: -1,
  Rating.neutral: 0,
  Rating.positive: 1,
};

const _$VehicleTypeEnumMap = {
  VehicleType.teslaModelS: 'teslaModelS',
};

PlugshareUser _$PlugshareUserFromJson(Map<String, dynamic> json) =>
    PlugshareUser(
      countryCode: json['country_code'] as String?,
      displayName: json['display_name'] as String,
      id: json['id'] as String,
      vehicleDescription: json['vehicle_description'] as String?,
      vehicleType: $enumDecodeNullable(
          _$VehicleTypeEnumMap, json['vehicle_type'],
          unknownValue: VehicleType.teslaModelS),
    );

Map<String, dynamic> _$PlugshareUserToJson(PlugshareUser instance) =>
    <String, dynamic>{
      'country_code': instance.countryCode,
      'display_name': instance.displayName,
      'id': instance.id,
      'vehicle_description': instance.vehicleDescription,
      'vehicle_type': _$VehicleTypeEnumMap[instance.vehicleType],
    };
