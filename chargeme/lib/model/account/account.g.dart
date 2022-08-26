// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      id: json['id'] as String,
      displayName: json['display_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photo_url'] as String?,
      signInService:
          $enumDecode(_$SignInServiceEnumMap, json['sign_in_service']),
      vehicleType:
          $enumDecodeNullable(_$VehicleTypeEnumMap, json['vehicle_type']),
      vehicleName: json['vehicle_name'] as String?,
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => Photo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'display_name': instance.displayName,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'photo_url': instance.photoUrl,
      'sign_in_service': _$SignInServiceEnumMap[instance.signInService]!,
      'vehicle_type': _$VehicleTypeEnumMap[instance.vehicleType],
      'vehicle_name': instance.vehicleName,
      'reviews': instance.reviews,
      'photos': instance.photos,
    };

const _$SignInServiceEnumMap = {
  SignInService.email: 'email',
  SignInService.google: 'google',
  SignInService.apple: 'apple',
};

const _$VehicleTypeEnumMap = {
  VehicleType.teslaModelS: 'teslaModelS',
};
