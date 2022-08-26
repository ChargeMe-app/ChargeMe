import 'package:chargeme/components/account_manager/account_manager.dart';
import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/view/login/phone_register_view.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class ProfileView extends StatefulWidget {
  AccountManager accountManager;

  ProfileView({required this.accountManager});

  @override
  State<ProfileView> createState() => _ProfileView();
}

class _ProfileView extends State<ProfileView> {
  String errorText = "";

  @override
  Widget build(BuildContext context) {
    if (widget.accountManager.currentAccount != null) {
      final account = widget.accountManager.currentAccount!;
      return Scaffold(
          appBar: AppBar(title: const Text("Your profile"), backgroundColor: ColorPallete.violetBlue),
          body: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Center(
                  child: Column(children: [
                SizedBox(
                    height: 128,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(64),
                        child: account.photoUrl == null
                            ? Image.asset("assets/icons/plugs/commando3pin.png")
                            : Image.network(account.photoUrl!))),
                const SizedBox(height: 12),
                titleText("Display name"),
                account.displayName == null ? Container() : textField(account.displayName!, true),
                const SizedBox(height: 12),
                titleText("Email"),
                account.email == null ? Container() : textField(account.email!, false),
                const SizedBox(height: 12),
                SimpleButton(
                    color: ColorPallete.violetBlue,
                    text: "Log out",
                    onPressed: () async {
                      await widget.accountManager.signOut();
                      setState(() {});
                    }),
                const SizedBox(height: 12),
                SimpleButton(color: ColorPallete.redCinnabar, text: "Delete account", onPressed: () {})
              ]))));
    } else {
      return signInView();
    }
  }

  Widget signInView() {
    return Scaffold(
        appBar: AppBar(title: const Text("Sign in"), backgroundColor: ColorPallete.violetBlue),
        body: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(children: [
              titleText("Join ChargeMe cummunity for free"),
              const SizedBox(height: 24),
              SizedBox(
                  height: 64,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8), child: Image.asset("assets/app_icon/icon.png"))),
              const SizedBox(height: 24),
              Container(
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                          primary: Colors.white,
                          minimumSize: const Size.fromHeight(50),
                          side: const BorderSide()),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Container(height: 24, child: Image.asset("assets/icons/other/g-logo.png")),
                        SizedBox(width: 4),
                        Text("Sign in with Google", style: TextStyle(color: Colors.grey, fontSize: 18))
                      ]),
                      onPressed: () async {
                        final success = await widget.accountManager.googleSingIn();
                        setState(() {
                          errorText = success ? "" : "Unsuccessfull sign in";
                        });
                      })),
              const SizedBox(height: 8),
              SizedBox(
                  height: 50,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: SignInWithAppleButton(onPressed: () async {
                        final success = await widget.accountManager.appleSignIn();
                        setState(() {
                          errorText = success ? "" : "Unsuccessfull sign in";
                        });
                      }))),
              const SizedBox(height: 12),
              Text(errorText, style: TextStyle(color: ColorPallete.redCinnabar))
            ])));
  }

  Widget titleText(String str) {
    return Text(str, style: TextStyle(color: ColorPallete.violetBlue, fontSize: 18, fontWeight: FontWeight.bold));
  }

  Widget textField(String value, bool enabled) {
    return TextFormField(
        initialValue: value,
        style: enabled ? TextStyle(color: Colors.black) : TextStyle(color: Colors.grey),
        decoration: InputDecoration(
            fillColor: ColorPallete.violetBlue,
            disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorPallete.violetBlue)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorPallete.violetBlue)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorPallete.violetBlue))),
        enabled: enabled);
  }
}
