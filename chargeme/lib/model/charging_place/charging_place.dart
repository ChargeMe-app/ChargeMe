import 'dart:convert';

import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/services.dart' show rootBundle;

part 'charging_place.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ChargingPlace {
  String name;
  String? description;
  String? phoneNumber;
  String? address;
  double latitude;
  double longitude;

  int? access;
  String? accessRestriction;
  String? accessRestrictionDescription;
  List<String>? accessRestrictions;

  bool? cost;
  String? costDescription;

  String? hours;
  bool? open247;

  List<Amenity>? amenities;
  List<Photo> photos;
  List<Review> reviews;
  List<Station> stations;

  double? score;

  int totalPhotos;
  int totalReviews;

  ChargingPlace(
      {required this.name,
      this.description,
      this.phoneNumber,
      this.address,
      required this.latitude,
      required this.longitude,
      this.access,
      this.accessRestriction,
      this.accessRestrictionDescription,
      this.accessRestrictions,
      this.cost,
      this.costDescription,
      this.hours,
      this.open247,
      this.amenities,
      required this.photos,
      required this.reviews,
      required this.stations,
      this.score,
      required this.totalPhotos,
      required this.totalReviews});

  factory ChargingPlace.fromJson(Map<String, dynamic> json) => _$ChargingPlaceFromJson(json);
  Map<String, dynamic> toJson() => _$ChargingPlaceToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Photo {
  String caption;
  DateTime createdAt;
  int id;
  Uri url;
  int userId;

  Photo({required this.caption, required this.createdAt, required this.id, required this.url, required this.userId});

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Review {
  String comment;
  ConnectorType? connectorType;
  DateTime createdAt;
  int id;
  int? outletId;
  int? stationId;
  Rating rating;
  String? vehicleName;
  @JsonKey(unknownEnumValue: VehicleType.teslaModelS)
  VehicleType? vehicleType;
  PlugshareUser user;

  Review(
      {required this.comment,
      this.connectorType,
      required this.createdAt,
      required this.id,
      this.outletId,
      this.stationId,
      required this.rating,
      this.vehicleName,
      this.vehicleType,
      required this.user});

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PlugshareUser {
  String? countryCode;
  String displayName;
  int id;
  String? vehicleDescription;
  @JsonKey(unknownEnumValue: VehicleType.teslaModelS)
  VehicleType? vehicleType;

  PlugshareUser(
      {this.countryCode, required this.displayName, required this.id, this.vehicleDescription, this.vehicleType});

  factory PlugshareUser.fromJson(Map<String, dynamic> json) => _$PlugshareUserFromJson(json);
  Map<String, dynamic> toJson() => _$PlugshareUserToJson(this);
}

enum Rating {
  @JsonValue(-1)
  negative,
  @JsonValue(0)
  neutral,
  @JsonValue(1)
  positive
}

extension RatingIcon on Rating {
  Icon get icon {
    switch (this) {
      case Rating.positive:
        return Icon(Icons.check_circle, color: ColorPallete.greenEmerald);
      case Rating.neutral:
        return Icon(Icons.info, color: ColorPallete.darkerBlue);
      case Rating.negative:
        return Icon(Icons.highlight_remove_rounded, color: ColorPallete.redCinnabar);
    }
  }
}

extension BeautifulScore on double {
  String get beautifulScore => this.toInt() == this ? this.toInt().toString() : this.toString();
}

Future<List<ChargingPlace>> getTestStation() async {
  List<ChargingPlace> stations;
  var response = await rootBundle.loadString('assets/test_station.json');

  stations = (json.decode(response) as List).map((i) => ChargingPlace.fromJson(i)).toList();
  return stations;
}
