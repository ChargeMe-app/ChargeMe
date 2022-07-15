import 'package:chargeme/model/charging_place/station.dart';
import 'package:json_annotation/json_annotation.dart';

part 'charging_place.g.dart';

@JsonSerializable()
class ChargingPlace {
  String name;
  String? description;
  String? phoneNumber;
  String? address;
  double latitude;
  double longitude;
  // Location location;
  List<ConnectorType> stationTypes;

  int? access;
  String? accessRestriction;
  String? accessRestrictionDescription;
  List<String>? accessRestrictions;

  bool? cost;
  String? costDescription;

  String? hours;
  bool? open247;

  // Hours? hours;
  List<Amenity>? amenities;
  bool isOpenOrActive;

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
      required this.stationTypes,
      this.access,
      this.accessRestriction,
      this.accessRestrictionDescription,
      this.accessRestrictions,
      this.cost,
      this.costDescription,
      this.hours,
      this.open247,
      this.amenities,
      required this.isOpenOrActive,
      required this.photos,
      required this.reviews,
      required this.stations,
      this.score,
      required this.totalPhotos,
      required this.totalReviews});

  factory ChargingPlace.fromJson(Map<String, dynamic> json) => _$ChargingPlaceFromJson(json);
  Map<String, dynamic> toJson() => _$ChargingPlaceToJson(this);
}

@JsonSerializable()
class Photo {
  String caption;
  DateTime createdAt;
  int id;
  Uri url;
  int userId;

  Photo({required this.caption, required this.createdAt, required this.id, required this.url, required this.userId});
}

@JsonSerializable()
class Review {
  String comment;
  ConnectorType? connectorType;
  DateTime createdAt;
  int id;
  int outletId;
  int stationId;
  Rating rating;
  String? vehicleName;
  VehicleType? vehicleType;
  PlugshareUser user;

  Review(
      {required this.comment,
      this.connectorType,
      required this.createdAt,
      required this.id,
      required this.outletId,
      required this.stationId,
      required this.rating,
      this.vehicleName,
      this.vehicleType,
      required this.user});

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

@JsonSerializable()
class PlugshareUser {
  String? countryCode;
  String displayName;
  int id;
  String? vehicleDescription;
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
