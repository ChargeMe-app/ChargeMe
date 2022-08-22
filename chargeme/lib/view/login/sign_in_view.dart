import 'package:chargeme/components/account_manager/account_manager.dart';
import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/view/login/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInView extends StatefulWidget {
  final AccountManager accountManager;

  const SignInView({required this.accountManager, super.key});

  @override
  State<SignInView> createState() => _SignInView();
}

class _SignInView extends State<SignInView> {
  String errorText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Register"), backgroundColor: ColorPallete.violetBlue),
        body: Center(
            child: Column(children: [
          ElevatedButton(
              child: Text("Google Sign In"),
              onPressed: () async {
                final success = await widget.accountManager.googleSingIn();
                if (success) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileView(accountManager: widget.accountManager),
                      ));
                }
                setState(() {
                  errorText = success ? "" : "Unsuccessfull sign in";
                });
              }),
          Text(errorText, style: TextStyle(color: ColorPallete.redCinnabar))
        ])));
  }
}
