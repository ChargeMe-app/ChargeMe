import 'dart:convert';

import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/gen/assets.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:chargeme/model/station_marker/station_marker.dart';
import 'package:chargeme/model/vehicle/vehicle_type.dart';
import 'package:chargeme/view/helper_views/svg_colored_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/services.dart' show rootBundle;

part 'charging_place.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ChargingPlace {
  String id;
  String name;
  String? description;
  String? phoneNumber;
  String? address;
  double latitude;
  double longitude;
  IconType iconType;

  int? access;
  String? accessRestriction;
  String? accessRestrictionDescription;
  List<String>? accessRestrictions;

  bool? cost;
  String? costDescription;

  String? hours;
  bool? open247;
  bool? comingSoon; // make non-optional

  List<Amenity>? amenities;
  List<Photo>? photos;
  List<Review>? reviews;
  List<Station> stations;

  double? score;

  int? totalPhotos;
  int? totalReviews;

  bool get isHomeCharger {
    return iconType == IconType.home;
  }

  ChargingPlace(
      {required this.id,
      required this.name,
      this.description,
      this.phoneNumber,
      this.address,
      required this.latitude,
      required this.longitude,
      required this.iconType,
      this.access,
      this.accessRestriction,
      this.accessRestrictionDescription,
      this.accessRestrictions,
      this.cost,
      this.costDescription,
      this.hours,
      this.open247,
      this.comingSoon,
      this.amenities,
      required this.photos,
      required this.reviews,
      required this.stations,
      this.score,
      this.totalPhotos,
      this.totalReviews});

  factory ChargingPlace.fromJson(Map<String, dynamic> json) => _$ChargingPlaceFromJson(json);
  Map<String, dynamic> toJson() => _$ChargingPlaceToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Photo {
  String? caption;
  DateTime createdAt;
  String id;
  String url;
  String userId;

  Photo({required this.caption, required this.createdAt, required this.id, required this.url, required this.userId});

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Review {
  String comment;
  ConnectorType? connectorType;
  DateTime createdAt;
  String id;
  String? outletId;
  String? stationId;
  Rating rating;
  String? vehicleName;
  @JsonKey(unknownEnumValue: VehicleType.unknown)
  VehicleType? vehicleType;
  String? userName;
  // PlugshareUser? user;

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
      this.userName});

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CheckIn {
  String userId;
  String stationId;
  String outletId;
  Rating rating;
  DateTime finishesAt;
  String userName;

  VehicleType? vehicleType;
  String comment;
  double? kilowatts;

  CheckIn(
      {required this.userId,
      required this.stationId,
      required this.outletId,
      required this.rating,
      required this.finishesAt,
      required this.userName,
      this.vehicleType,
      this.comment = "",
      this.kilowatts});

  factory CheckIn.fromJson(Map<String, dynamic> json) => _$CheckInFromJson(json);
  Map<String, dynamic> toJson() => _$CheckInToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PlugshareUser {
  String? countryCode;
  String displayName;
  String id;
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
  Widget get icon {
    switch (this) {
      case Rating.positive:
        return SvgPicture.asset(Asset.checkmarkRounded.path);
      case Rating.neutral:
        return SvgColoredIcon(assetPath: Asset.info.path, color: ColorPallete.darkerBlue);
      case Rating.negative:
        return SvgPicture.asset(Asset.xmarkRounded.path);
    }
  }
}

extension BeautifulScore on double {
  String get beautifulScore => toInt() == this ? toInt().toString() : toStringAsFixed(1).toString();
  Color get bgColor {
    if (this == 0) {
      return Colors.grey;
    } else if (this < 4) {
      return ColorPallete.redCinnabar;
    } else if (this < 7.5) {
      return ColorPallete.yellow;
    } else {
      return Colors.green;
    }
  }
}

Future<List<ChargingPlace>> getTestStation() async {
  List<ChargingPlace> stations;
  var response = await rootBundle.loadString('assets/temporary/test_station.json');

  stations = (json.decode(response) as List).map((i) => ChargingPlace.fromJson(i)).toList();
  return stations;
}
