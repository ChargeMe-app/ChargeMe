import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/model/charging_place/charging_place.dart';
import 'package:chargeme/view/charging_place/stations_list_view.dart';
import 'package:chargeme/view/helper_views/svg_colored_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:chargeme/extensions/string_extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:map_launcher/map_launcher.dart';

class DetailsView extends StatelessWidget {
  DetailsView({required this.place, this.icon});

  final ChargingPlace place;
  final BitmapDescriptor? icon;
  LatLng get latLng => LatLng(place.latitude, place.longitude);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(children: [
      place.address == null
          ? Container()
          : row(context, "assets/icons/common/pin.svg", l10n.address, place.address!.capitalizeEachWord,
              withSeparator: false),
      place.phoneNumber?.isEmpty ?? true ? Container() : rowPng("assets/icons/common/phone.png", place.phoneNumber!),
      place.cost == null
          ? Container()
          : row(context, "assets/icons/common/Parking.svg", l10n.parking, costText(context)),
      !shouldShowHours()
          ? Container()
          : row(context, "assets/icons/common/clock.svg", l10n.workingHours,
              place.open247! ? l10n.open247 : place.hours!),
      place.description?.isEmpty ?? true
          ? Container()
          : row(context, "assets/icons/common/info.svg", l10n.description, place.description!),
      ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: Stack(alignment: AlignmentDirectional.bottomEnd, children: [
            SizedBox(
                height: 120,
                child: GoogleMap(
                  myLocationButtonEnabled: false,
                  markers: {
                    Marker(
                        markerId: const MarkerId("123"), icon: icon ?? BitmapDescriptor.defaultMarker, position: latLng)
                  },
                  initialCameraPosition: CameraPosition(
                    target: latLng,
                    zoom: 13.0,
                  ),
                )),
            Container(
                height: 120,
                decoration: BoxDecoration(
                    border: Border.all(color: ColorPallete.violetBlue, width: 5),
                    borderRadius: BorderRadius.all(Radius.circular(15)))),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 4),
                child: MaterialButton(
                    color: ColorPallete.violetBlue,
                    onPressed: () => openMapsSheet(context),
                    child: Text(l10n.getDirections, style: const TextStyle(color: Colors.white)))),
          ])),
    ]);
  }

  Widget row(BuildContext context, String assetPath, String title, String text, {bool withSeparator = true}) {
    final l10n = AppLocalizations.of(context);
    return Column(children: [
      withSeparator ? Container(height: 1, color: ColorPallete.violetBlue) : Container(),
      Container(
          height: 55,
          child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                          title: Text(title),
                          titleTextStyle:
                              TextStyle(color: ColorPallete.violetBlue, fontSize: 24, fontWeight: FontWeight.bold),
                          children: [
                            Padding(padding: const EdgeInsets.fromLTRB(24, 0, 24, 8), child: Text(text)),
                            SimpleDialogOption(
                              child: Row(children: [Spacer(), Text(l10n.close, style: TextStyle(fontSize: 14))]),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ]);
                    });
              },
              child: Row(children: [
                const SizedBox(width: 8),
                Container(width: 32, child: SvgColoredIcon(assetPath: assetPath, color: ColorPallete.violetBlue)),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(text, maxLines: 2, style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 16)),
                )
              ])))
    ]);
  }

  Widget rowPng(String assetPath, String text) {
    return Column(children: [
      Container(height: 1, color: ColorPallete.violetBlue),
      Container(
          height: 55,
          child: Row(children: [
            const SizedBox(width: 8),
            Image.asset(assetPath, width: 30),
            const SizedBox(width: 8),
            Flexible(child: Text(text, maxLines: 2, style: const TextStyle(fontSize: 16)))
          ]))
    ]);
  }

  bool shouldShowHours() {
    if (place.open247 == null) {
      return false;
    }
    if (!place.open247! && (place.hours?.isEmpty ?? true)) {
      return false;
    }
    return true;
  }

  String costText(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (!place.cost!) {
      return l10n.free;
    }
    if (!(place.costDescription?.isEmpty ?? true)) {
      return place.costDescription!;
    }
    return "l10n.requiresFee";
  }

  openMapsSheet(context) async {
    try {
      final coords = Coords(place.latitude, place.longitude);
      final title = place.name;
      final availableMaps = await MapLauncher.installedMaps;
      final l10n = AppLocalizations.of(context);

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Wrap(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(children: [
                        const Spacer(),
                        Text(l10n.getDirections,
                            style:
                                TextStyle(color: ColorPallete.violetBlue, fontSize: 18, fontWeight: FontWeight.bold)),
                        const Spacer()
                      ])),
                  for (var map in availableMaps)
                    ListTile(
                      onTap: () => map.showMarker(
                        coords: coords,
                        title: title,
                      ),
                      title: Text(map.mapName),
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: SvgPicture.asset(
                            map.icon,
                            height: 30.0,
                            width: 30.0,
                          )),
                    ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
