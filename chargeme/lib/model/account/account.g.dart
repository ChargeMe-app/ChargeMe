// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      id: json['id'] as String,
      displayName: json['display_name'] as String?,
      contacts: json['contacts'] == null
          ? null
          : UserContacts.fromJson(json['contacts'] as Map<String, dynamic>),
      photoUrl: json['photo_url'] as String?,
      signInService:
          $enumDecode(_$SignInServiceEnumMap, json['sign_in_service']),
      vehicles: (json['vehicles'] as List<dynamic>?)
          ?.map((e) => Vehicle.fromJson(e as Map<String, dynamic>))
          .toList(),
      vehicleName: json['vehicle_name'] as String?,
      favourites: (json['favourites'] as List<dynamic>?)
          ?.map((e) => ChargingPlace.fromJson(e as Map<String, dynamic>))
          .toList(),
      recentPlaces: (json['recent_places'] as List<dynamic>?)
          ?.map((e) => ChargingPlace.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => Photo.fromJson(e as Map<String, dynamic>))
          .toList(),
      stats: json['stats'] == null
          ? null
          : UserStats.fromJson(json['stats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'display_name': instance.displayName,
      'photo_url': instance.photoUrl,
      'sign_in_service': _$SignInServiceEnumMap[instance.signInService]!,
      'vehicles': instance.vehicles,
      'vehicle_name': instance.vehicleName,
      'favourites': instance.favourites,
      'recent_places': instance.recentPlaces,
      'reviews': instance.reviews,
      'photos': instance.photos,
      'contacts': instance.contacts,
      'stats': instance.stats,
    };

const _$SignInServiceEnumMap = {
  SignInService.email: 'email',
  SignInService.google: 'google',
  SignInService.apple: 'apple',
};

UserStats _$UserStatsFromJson(Map<String, dynamic> json) => UserStats(
      totalCheckIns: json['total_check_ins'] as int,
      photosAdded: json['photos_added'] as int,
      placesAdded: json['places_added'] as int,
    );

Map<String, dynamic> _$UserStatsToJson(UserStats instance) => <String, dynamic>{
      'total_check_ins': instance.totalCheckIns,
      'photos_added': instance.photosAdded,
      'places_added': instance.placesAdded,
    };

UserContacts _$UserContactsFromJson(Map<String, dynamic> json) => UserContacts(
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      telegram: json['telegram'] as String?,
    );

Map<String, dynamic> _$UserContactsToJson(UserContacts instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'telegram': instance.telegram,
    };
