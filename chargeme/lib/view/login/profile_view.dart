import 'package:chargeme/components/account_manager/account_manager.dart';
import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/view/helper_views/svg_colored_icon.dart';
import 'package:chargeme/view/login/phone_register_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:chargeme/model/charging_place/vehicle_type.dart';
import 'package:chargeme/gen/assets.dart';

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
              child: SingleChildScrollView(
                  child: Column(children: [
                Row(children: [
                  SizedBox(
                      height: 128,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(64),
                          child: account.photoUrl == null
                              ? Image.asset(Asset.commando3pin.path)
                              : Image.network(account.photoUrl!))),
                  const SizedBox(width: 12),
                  account.displayName == null
                      ? Container()
                      : Flexible(
                          child: Text(account.displayName!,
                              maxLines: null, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))),
                ]),
                const SizedBox(height: 12),
                Row(children: [
                  Text("Vehicle:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  CupertinoButton(
                      child: Text(account.vehicleType == null ? "Choose" : account.vehicleType!.fullName,
                          style: TextStyle(color: ColorPallete.violetBlue, fontSize: 20)),
                      onPressed: () {})
                ]),
                const SizedBox(height: 4),
                profileBox(title: "Your stuff", children: [
                  profileCell(title: "Favourites", iconPath: Asset.star.path),
                  separator(),
                  profileCell(title: "Add home charger", iconPath: Asset.homeIcon.path)
                ]),
                const SizedBox(height: 12),
                profileBox(title: "Your statistics", children: [
                  profileCell(title: "Total check-ins", count: 0),
                  separator(),
                  profileCell(title: "Photos added", count: 0),
                  separator(),
                  profileCell(title: "Places added", count: 0)
                ]),
                // titleText("Email"),
                // account.contacts?.email == null ? Container() : textField(account.contacts!.email!, false),
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
                  child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset(Asset.icon.path))),
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
                        Container(height: 24, child: Image.asset(Asset.gLogo.path)),
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

  Widget separator() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8), child: Container(height: 1, color: ColorPallete.violetBlue));
  }

  Widget profileBox({String? title, required List<Widget> children}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      title == null
          ? Container()
          : Text(title, style: TextStyle(color: ColorPallete.violetBlue, fontSize: 20, fontWeight: FontWeight.bold)),
      Container(
          decoration: BoxDecoration(
              border: Border.all(color: ColorPallete.violetBlue, width: 5),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Column(children: children))
    ]);
  }

  Widget profileCell({required String title, int? count, Function? onTap, String? iconPath}) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(children: [
          iconPath == null
              ? Container()
              : SizedBox(
                  width: 40, height: 40, child: SvgColoredIcon(assetPath: iconPath, color: ColorPallete.violetBlue)),
          iconPath == null ? Container() : SizedBox(width: 8),
          Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Spacer(),
          count == null
              ? SvgPicture.asset(Asset.chevronRight.path, height: 30, width: 30)
              : Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Text(count.toString(),
                      style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold)))
        ]));
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
