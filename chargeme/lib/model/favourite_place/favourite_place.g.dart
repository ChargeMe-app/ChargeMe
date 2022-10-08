// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouritePlace _$FavouritePlaceFromJson(Map<String, dynamic> json) =>
    FavouritePlace(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      iconType: $enumDecode(_$IconTypeEnumMap, json['icon_type']),
    );

Map<String, dynamic> _$FavouritePlaceToJson(FavouritePlace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'icon_type': _$IconTypeEnumMap[instance.iconType]!,
    };

const _$IconTypeEnumMap = {
  IconType.publicStandard: 'G',
  IconType.repairStandard: 'GR',
  IconType.publicFast: 'Y',
  IconType.repairFast: 'YR',
  IconType.home: 'H',
  IconType.restricted: 'B',
};
