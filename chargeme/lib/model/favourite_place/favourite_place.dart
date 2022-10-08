import 'package:chargeme/model/station_marker/station_marker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favourite_place.g.dart';

// used for storing favourite places locally
@JsonSerializable(fieldRename: FieldRename.snake)
class FavouritePlace {
  String id;
  String name;
  String address;
  IconType iconType;

  FavouritePlace({required this.id, required this.name, required this.address, required this.iconType});

  factory FavouritePlace.fromJson(Map<String, dynamic> json) => _$FavouritePlaceFromJson(json);
  Map<String, dynamic> toJson() => _$FavouritePlaceToJson(this);
}
