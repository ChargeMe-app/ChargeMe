import 'package:chargeme/model/charging_place/charging_place.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:chargeme/model/charging_place/vehicle_type.dart';
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

  VehicleType? vehicleType;
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
      this.vehicleType,
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

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
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
