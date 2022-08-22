import 'dart:convert';
import 'dart:io';

import 'package:chargeme/model/account/account.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AccountManager {
  Account? currentAccount;
  String? token;

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
        print(auth.idToken); // send to backend
        final user = Account.fromGoogle(account);
        storeAccount(user);
        return true;
      }
      return false;
    } catch (error) {
      print(error);
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
      print(error);
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
      print(err);
    }
  }

  Future<void> deleteStoredAccount() async {
    try {
      final file = await storedFile;
      file.delete();
    } catch (err) {
      print(err);
    }
  }
}
