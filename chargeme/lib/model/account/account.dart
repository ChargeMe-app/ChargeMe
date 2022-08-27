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
  String? phoneNumber;
  String? email;
  String? photoUrl; // URL
  SignInService signInService;

  VehicleType? vehicleType;
  String? vehicleName;

  List<Review>? reviews;
  List<Photo>? photos;

  Account(
      {required this.id,
      this.displayName,
      this.phoneNumber,
      this.email,
      this.photoUrl,
      required this.signInService,
      this.vehicleType,
      this.vehicleName,
      this.reviews,
      this.photos});

  Account.fromGoogle(GoogleSignInAccount googleAccount)
      : id = googleAccount.id,
        displayName = googleAccount.displayName,
        email = googleAccount.email,
        photoUrl = googleAccount.photoUrl,
        signInService = SignInService.google;

  Account.fromApple(AuthorizationCredentialAppleID appleAccount)
      : id = appleAccount.userIdentifier!,
        displayName = appleAccount.givenName,
        email = appleAccount.email,
        signInService = SignInService.apple;

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

enum SignInService { email, google, apple }
