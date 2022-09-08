import 'dart:convert';
import 'dart:io';

import 'package:chargeme/components/analytics_manager/analytics_manager.dart';
import 'package:chargeme/components/helpers/ip.dart';
import 'package:chargeme/model/account/account.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;

class AccountManager {
  Account? currentAccount;
  AnalyticsManager analytics;

  AccountManager({required this.analytics});

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'profile',
  ]);

  Future<File> get storedFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/current_account.json");
  }

  Future<bool> googleSingIn() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account != null) {
        final auth = await account.authentication;
        Map<String, dynamic> postBody = {
          "sign_type": "google",
          "photo_url": account.photoUrl,
          "display_name": account.displayName,
          "email": account.email,
          "user_identifier": account.id,
          "google_credentials": {"id_token": auth.idToken, "access_token": auth.accessToken}
        };
        final response = await http.post(Uri.parse("http://${IP.current}:8080/v1/auth"), body: jsonEncode(postBody));
        if (response.statusCode == 200) {
          final body = jsonDecode(response.body);
          final userId = body["user_id"];
          // get user data
          final user = Account.fromGoogle(account, userId);
          storeAccount(user);
          analytics.logEvent("sign_in", params: {"status": "success", "sign_type": "google", "user_id": userId});
          return true;
        }
      }
      return false;
    } catch (error) {
      analytics.logErrorEvent(error.toString());
      return false;
    }
  }

  Future<bool> appleSignIn() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ]);

      // Send to backend, store user info on first sign in because it will not be available in future
      String? displayName;
      if (credential.givenName != null && credential.familyName != null) {
        displayName = credential.givenName! + " " + credential.familyName!;
      }
      print(credential.authorizationCode);
      print(credential.email);
      print(credential.familyName);
      print(credential.givenName);
      print(credential.userIdentifier);
      print(Platform.isAndroid);

      final user = Account.fromApple(credential);
      storeAccount(user);

      return true;
    } catch (error) {
      analytics.logErrorEvent(error.toString());
      return false;
    }
  }

  Future<bool> signOut() async {
    if (currentAccount == null) return false;
    switch (currentAccount!.signInService) {
      case SignInService.email:
        // TODO: Handle this case.
        return false;
      case SignInService.google:
        await _googleSignIn.signOut();
        break;
      case SignInService.apple:
        break;
    }
    currentAccount = null;
    deleteStoredAccount();
    return true;
  }

  Future<void> storeAccount(Account account) async {
    currentAccount = account;
    final file = await storedFile;
    file.writeAsString(jsonEncode(account.toJson()));
  }

  Future<void> tryLoadStoredAccount() async {
    try {
      final file = await storedFile;
      final fileString = await file.readAsString();
      final json = jsonDecode(fileString);
      currentAccount = Account.fromJson(json);
    } catch (err) {
      analytics.logErrorEvent(err.toString());
    }
  }

  Future<void> deleteStoredAccount() async {
    try {
      final file = await storedFile;
      file.delete();
    } catch (err) {
      analytics.logErrorEvent(err.toString());
    }
  }
}
