import 'package:chargeme/model/charging_place/charging_place.dart';
import 'package:chargeme/model/vehicle/vehicle.dart';
import 'package:chargeme/model/vehicle/vehicle_type.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'account.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Account {
  String id;
  String? displayName;
  String? photoUrl; // URL
  SignInService signInService;

  List<Vehicle>? vehicles;
  String? vehicleName;

  List<ChargingPlace>? favourites;
  List<ChargingPlace>? recentPlaces;

  List<Review>? reviews;
  List<Photo>? photos;

  UserContacts? contacts;
  UserStats? stats;

  Account(
      {required this.id,
      this.displayName,
      this.contacts,
      this.photoUrl,
      required this.signInService,
      this.vehicles,
      this.vehicleName,
      this.favourites,
      this.recentPlaces,
      this.reviews,
      this.photos,
      this.stats});

  Account.fromGoogle(GoogleSignInAccount googleAccount, this.id)
      : displayName = googleAccount.displayName,
        contacts = UserContacts(email: googleAccount.email),
        photoUrl = googleAccount.photoUrl,
        signInService = SignInService.google;

  Account.fromApple(AuthorizationCredentialAppleID appleAccount)
      : id = appleAccount.userIdentifier!,
        displayName = appleAccount.givenName,
        contacts = UserContacts(email: appleAccount.email),
        signInService = SignInService.apple;

  Account.fromUserData(Map<String, dynamic> data, this.id)
      : displayName = data["display_name"],
        photoUrl = data["photo_url"],
        signInService = SignInService.apple, // data["sign_in_service"],
        stats = UserStats(totalCheckIns: data["total_reviews"], photosAdded: 0, placesAdded: 0),
        vehicles = getVehicleTypesFromJson(data);

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);

  static List<Vehicle> getVehicleTypesFromJson(Map<String, dynamic> data) {
    List<Vehicle> result = [];
    final List<dynamic> vehiclesList = data["vehicle_type"];
    vehiclesList.forEach((e) {
      String id = e["id"] ?? "123123";
      VehicleType vehicleType = VehicleType.values.firstWhere((el) => e["vehicle_type"] == el.value);
      result.add(Vehicle(id: id, type: vehicleType));
    });
    return result;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UserStats {
  int totalCheckIns;
  int photosAdded;
  int placesAdded;

  UserStats({required this.totalCheckIns, required this.photosAdded, required this.placesAdded});

  factory UserStats.fromJson(Map<String, dynamic> json) => _$UserStatsFromJson(json);
  Map<String, dynamic> toJson() => _$UserStatsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UserContacts {
  String? email;
  String? phoneNumber;
  String? telegram;

  UserContacts({this.email, this.phoneNumber, this.telegram});

  factory UserContacts.fromJson(Map<String, dynamic> json) => _$UserContactsFromJson(json);
  Map<String, dynamic> toJson() => _$UserContactsToJson(this);
}

enum SignInService { email, google, apple }
