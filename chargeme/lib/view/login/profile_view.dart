import 'package:chargeme/components/account_manager/account_manager.dart';
import 'package:chargeme/components/analytics_manager/analytics_manager.dart';
import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/gen/l10n.dart';
import 'package:chargeme/main.dart';
import 'package:chargeme/view/add_station/add_station_view.dart';
import 'package:chargeme/view/helper_views/svg_colored_icon.dart';
import 'package:chargeme/view/login/choose_vehicle_view.dart';
import 'package:chargeme/view/login/favourite_places_view.dart';
import 'package:chargeme/view/login/phone_register_view.dart';
import 'package:chargeme/view/login/user_vehicles_view.dart';
import 'package:chargeme/view_model/add_station_view_model.dart';
import 'package:chargeme/view_model/choose_vehicle_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:chargeme/model/vehicle/vehicle_type.dart';
import 'package:chargeme/gen/assets.dart';

class ProfileView extends StatefulWidget {
  AccountManager accountManager;
  AnalyticsManager analyticsManager;

  ProfileView({required this.accountManager, required this.analyticsManager});

  @override
  State<ProfileView> createState() => _ProfileView();
}

class _ProfileView extends State<ProfileView> with RouteAware {
  String errorText = "";

  @override
  void initState() {
    super.initState();
    updateAccount();
  }

  Future<void> updateAccount() async {
    await widget.accountManager.updateAccountInfo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.accountManager.currentAccount != null) {
      final account = widget.accountManager.currentAccount!;
      return Scaffold(
          appBar: AppBar(title: Text(L10n.yourProfile.str), backgroundColor: ColorPallete.violetBlue),
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
                              : Image.network(account.photoUrl!, errorBuilder: (context, error, stackTrace) {
                                  return Container(color: Colors.grey);
                                }))),
                  const SizedBox(width: 12),
                  account.displayName == null
                      ? Container()
                      : Flexible(
                          child: Text(account.displayName!,
                              maxLines: null, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))),
                ]),
                const SizedBox(height: 12),
                Row(children: [
                  Text("${L10n.vehicle.str}:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Consumer<ChooseVehicleViewModel>(
                      builder: (context, chooseVehicleVM, child) => CupertinoButton(
                          child: Text(
                              chooseVehicleVM.chosenVehicle == null
                                  ? L10n.choose.str
                                  : chooseVehicleVM.chosenVehicle!.type.fullName,
                              style: TextStyle(color: ColorPallete.violetBlue, fontSize: 20)),
                          onPressed: () {
                            if (chooseVehicleVM.vehicles.isEmpty) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => ChooseVehicleView(shouldSelectOnPop: true)));
                            } else {
                              chooseVehicleVM.onlyChoosing = false;
                              Navigator.push(context, MaterialPageRoute(builder: (context) => UserVehiclesView()));
                            }
                          }))
                ]),
                const SizedBox(height: 4),
                profileBox(title: L10n.yourStuff.str, children: [
                  profileCell(
                      title: L10n.favourites.str,
                      iconPath: Asset.star.path,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FavouritePlacesView()));
                      }),
                  separator(),
                  profileCell(
                      title: L10n.addHomeCharger.str,
                      iconPath: Asset.homeIcon.path,
                      onTap: () {
                        context.read<AddStationViewModel>().isHomeCharger = true;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddStationView()));
                      })
                ]),
                const SizedBox(height: 12),
                profileBox(title: L10n.yourStatistics.str, children: [
                  profileCell(title: L10n.totalCheckins.str, count: 0),
                  separator(),
                  profileCell(title: L10n.photosAdded.str, count: 0),
                  separator(),
                  profileCell(title: L10n.placesAdded.str, count: 0)
                ]),
                const SizedBox(height: 12),
                SimpleButton(
                    color: ColorPallete.violetBlue,
                    text: L10n.logOut.str,
                    onPressed: () async {
                      await widget.accountManager.signOut();
                      setState(() {});
                    }),
                const SizedBox(height: 12),
                SimpleButton(color: ColorPallete.redCinnabar, text: L10n.deleteAccount.str, onPressed: () {}),
                const SizedBox(height: 24)
              ]))));
    } else {
      return SignInView(
          accountManager: widget.accountManager,
          onSuccess: () {
            setState(() {});
          });
    }
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
    final screenWidthWithPadding = MediaQuery.of(context).size.width - 10;
    return InkWell(
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(children: [
              iconPath == null
                  ? Container()
                  : SizedBox(
                      width: 40,
                      height: 40,
                      child: SvgColoredIcon(assetPath: iconPath, color: ColorPallete.violetBlue)),
              iconPath == null ? Container() : SizedBox(width: 8),
              SizedBox(
                  width: screenWidthWithPadding - (iconPath == null ? 0 : 40) - 66,
                  child: Text(title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
              const Spacer(),
              count == null
                  ? SvgPicture.asset(Asset.chevronRight.path, height: 30, width: 30)
                  : Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Text(count.toString(),
                          style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold)))
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

class SignInView extends StatefulWidget {
  AccountManager accountManager;
  Function? onSuccess;

  SignInView({required this.accountManager, this.onSuccess});

  @override
  State<SignInView> createState() => _SignInView();
}

class _SignInView extends State<SignInView> {
  String errorText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(L10n.signIn.str), backgroundColor: ColorPallete.violetBlue),
        body: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(children: [
              titleText(L10n.joinChargemeCummunityForFree.str),
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
                        Text(L10n.signInWithGoogle.str, style: TextStyle(color: Colors.grey, fontSize: 18))
                      ]),
                      onPressed: () async {
                        final success = await widget.accountManager.googleSingIn();
                        if (success && widget.onSuccess != null) {
                          widget.onSuccess!();
                        } else {
                          setState(() {
                            errorText = success ? "" : L10n.unsuccessfullSignIn.str;
                          });
                        }
                      })),
              const SizedBox(height: 8),
              SizedBox(
                  height: 50,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: SignInWithAppleButton(onPressed: () async {
                        final success = await widget.accountManager.appleSignIn();
                        if (success && widget.onSuccess != null) {
                          widget.onSuccess!();
                        } else {
                          setState(() {
                            errorText = success ? "" : L10n.unsuccessfullSignIn.str;
                          });
                        }
                      }))),
              const SizedBox(height: 12),
              Text(errorText, style: TextStyle(color: ColorPallete.redCinnabar))
            ])));
  }

  Widget titleText(String str) {
    return Text(str, style: TextStyle(color: ColorPallete.violetBlue, fontSize: 18, fontWeight: FontWeight.bold));
  }
}
