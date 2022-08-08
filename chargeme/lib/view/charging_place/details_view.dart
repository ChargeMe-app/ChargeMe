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
      Container(height: 1, color: ColorPallete.violetBlue),
      place.address == null
          ? Container()
          : row(context, "assets/icons/common/pin.svg", l10n.address, place.address!.capitalizeEachWord),
      Container(height: 1, color: ColorPallete.violetBlue),
      place.phoneNumber == null ? Container() : rowPng("assets/icons/common/phone.png", place.phoneNumber!),
      Container(height: 1, color: ColorPallete.violetBlue),
      place.cost == null
          ? Container()
          : row(context, "assets/icons/common/Parking.svg", l10n.parking, "${l10n.parking}: ${l10n.free}"),
      Container(height: 1, color: ColorPallete.violetBlue),
      !shouldShowHours()
          ? Container()
          : row(context, "assets/icons/common/clock.svg", l10n.workingHours,
              place.open247! ? "Круглосуточно" : place.hours!),
      Container(height: 1, color: ColorPallete.violetBlue),
      place.description == null
          ? Container()
          : row(context, "assets/icons/common/info.svg", l10n.description, place.description!),
      Container(height: 1, color: ColorPallete.violetBlue),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Stack(alignment: AlignmentDirectional.bottomEnd, children: [
            SizedBox(
                height: 100,
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
            MaterialButton(
                color: ColorPallete.violetBlue,
                onPressed: () => openMapsSheet(context),
                child: Text(l10n.getDirections, style: const TextStyle(color: Colors.white))),
          ])),
      Container(height: 1, color: ColorPallete.violetBlue),
    ]);
  }

  Widget row(BuildContext context, String assetPath, String title, String text) {
    final l10n = AppLocalizations.of(context);
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
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
              SvgColoredIcon(assetPath: assetPath, color: ColorPallete.violetBlue),
              const SizedBox(width: 8),
              Flexible(
                child: Text(text, maxLines: 2, style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 16)),
              )
            ])));
  }

  Widget rowPng(String assetPath, String text) {
    return Row(children: [
      const SizedBox(width: 8),
      Image.asset(assetPath, width: 30),
      const SizedBox(width: 8),
      Flexible(child: Text(text, maxLines: 2, style: const TextStyle(fontSize: 16)))
    ]);
  }

  bool shouldShowHours() {
    if (place.open247 == null) {
      return false;
    }
    if (!place.open247! && place.hours == null) {
      return false;
    }
    return true;
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

// class DetailsView extends StatelessWidget {
//   DetailsView({required this.latitude, required this.longitude, this.icon, this.address, this.phoneNumber});

//   final double latitude;
//   final double longitude;
//   final BitmapDescriptor? icon;
//   final String? address;
//   final String? phoneNumber;
//   LatLng get latLng => LatLng(latitude, longitude);

//   @override
//   Widget build(BuildContext context) {
//     var l10n = AppLocalizations.of(context);
//     return BoxWithTitle(title: l10n.details, footer: l10n.getDirections, children: [
//       address == null ? Container() : row(Icons.location_pin, address!.capitalizeEachWord),
//       const SizedBox(height: 8),
//       phoneNumber == null ? Container() : row(Icons.phone_iphone, phoneNumber!),
//       const SizedBox(height: 8),
      // SizedBox(
      //     height: 100,
      //     child: GoogleMap(
      //       myLocationButtonEnabled: false,
      //       markers: {
      //         Marker(markerId: const MarkerId("123"), icon: icon ?? BitmapDescriptor.defaultMarker, position: latLng)
      //       },
      //       initialCameraPosition: CameraPosition(
      //         target: latLng,
      //         zoom: 13.0,
      //       ),
      //     )),
//       const SizedBox(height: 8),
//     ]);
//   }

  // Widget row(IconData iconData, String text) {
  //   return Row(
  //       children: [Icon(iconData, size: 36), Flexible(child: Text(text, maxLines: 2, style: TextStyle(fontSize: 16)))]);
  // }
// }
