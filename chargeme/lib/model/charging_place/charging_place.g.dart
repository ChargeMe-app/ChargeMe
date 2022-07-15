// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charging_place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargingPlace _$ChargingPlaceFromJson(Map<String, dynamic> json) =>
    ChargingPlace(
      name: json['name'] as String,
      description: json['description'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      stationTypes: (json['stationTypes'] as List<dynamic>)
          .map((e) => $enumDecode(_$ConnectorTypeEnumMap, e))
          .toList(),
      access: json['access'] as int?,
      accessRestriction: json['accessRestriction'] as String?,
      accessRestrictionDescription:
          json['accessRestrictionDescription'] as String?,
      accessRestrictions: (json['accessRestrictions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      cost: json['cost'] as bool?,
      costDescription: json['costDescription'] as String?,
      hours: json['hours'] as String?,
      open247: json['open247'] as bool?,
      amenities: (json['amenities'] as List<dynamic>?)
          ?.map((e) => Amenity.fromJson(e as Map<String, dynamic>))
          .toList(),
      isOpenOrActive: json['isOpenOrActive'] as bool,
      photos: (json['photos'] as List<dynamic>)
          .map((e) => Photo.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      stations: (json['stations'] as List<dynamic>)
          .map((e) => Station.fromJson(e as Map<String, dynamic>))
          .toList(),
      score: (json['score'] as num?)?.toDouble(),
      totalPhotos: json['totalPhotos'] as int,
      totalReviews: json['totalReviews'] as int,
    );

Map<String, dynamic> _$ChargingPlaceToJson(ChargingPlace instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'stationTypes':
          instance.stationTypes.map((e) => _$ConnectorTypeEnumMap[e]).toList(),
      'access': instance.access,
      'accessRestriction': instance.accessRestriction,
      'accessRestrictionDescription': instance.accessRestrictionDescription,
      'accessRestrictions': instance.accessRestrictions,
      'cost': instance.cost,
      'costDescription': instance.costDescription,
      'hours': instance.hours,
      'open247': instance.open247,
      'amenities': instance.amenities,
      'isOpenOrActive': instance.isOpenOrActive,
      'photos': instance.photos,
      'reviews': instance.reviews,
      'stations': instance.stations,
      'score': instance.score,
      'totalPhotos': instance.totalPhotos,
      'totalReviews': instance.totalReviews,
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

Photo _$PhotoFromJson(Map<String, dynamic> json) => Photo(
      caption: json['caption'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      id: json['id'] as int,
      url: Uri.parse(json['url'] as String),
      userId: json['userId'] as int,
    );

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'caption': instance.caption,
      'createdAt': instance.createdAt.toIso8601String(),
      'id': instance.id,
      'url': instance.url.toString(),
      'userId': instance.userId,
    };

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      comment: json['comment'] as String,
      connectorType:
          $enumDecodeNullable(_$ConnectorTypeEnumMap, json['connectorType']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      id: json['id'] as int,
      outletId: json['outletId'] as int,
      stationId: json['stationId'] as int,
      rating: $enumDecode(_$RatingEnumMap, json['rating']),
      vehicleName: json['vehicleName'] as String?,
      vehicleType:
          $enumDecodeNullable(_$VehicleTypeEnumMap, json['vehicleType']),
      user: PlugshareUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'comment': instance.comment,
      'connectorType': _$ConnectorTypeEnumMap[instance.connectorType],
      'createdAt': instance.createdAt.toIso8601String(),
      'id': instance.id,
      'outletId': instance.outletId,
      'stationId': instance.stationId,
      'rating': _$RatingEnumMap[instance.rating],
      'vehicleName': instance.vehicleName,
      'vehicleType': _$VehicleTypeEnumMap[instance.vehicleType],
      'user': instance.user,
    };

const _$RatingEnumMap = {
  Rating.negative: -1,
  Rating.neutral: 0,
  Rating.positive: 1,
};

const _$VehicleTypeEnumMap = {
  VehicleType.teslaModelS: 4,
};

PlugshareUser _$PlugshareUserFromJson(Map<String, dynamic> json) =>
    PlugshareUser(
      countryCode: json['countryCode'] as String?,
      displayName: json['displayName'] as String,
      id: json['id'] as int,
      vehicleDescription: json['vehicleDescription'] as String?,
      vehicleType:
          $enumDecodeNullable(_$VehicleTypeEnumMap, json['vehicleType']),
    );

Map<String, dynamic> _$PlugshareUserToJson(PlugshareUser instance) =>
    <String, dynamic>{
      'countryCode': instance.countryCode,
      'displayName': instance.displayName,
      'id': instance.id,
      'vehicleDescription': instance.vehicleDescription,
      'vehicleType': _$VehicleTypeEnumMap[instance.vehicleType],
    };
