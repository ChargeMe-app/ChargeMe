import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/view/charging_place/stations_list_view.dart';
import 'package:chargeme/view/helper_views/svg_colored_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:chargeme/extensions/string_extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailsView extends StatelessWidget {
  DetailsView(
      {required this.latitude,
      required this.longitude,
      this.icon,
      this.description,
      this.address,
      this.phoneNumber,
      this.hours,
      this.isOpen247,
      this.cost,
      this.costDescription});

  final double latitude;
  final double longitude;
  final BitmapDescriptor? icon;
  final String? description;
  final String? address;
  final String? phoneNumber;
  final String? hours;
  final bool? isOpen247;
  final bool? cost;
  final String? costDescription;
  LatLng get latLng => LatLng(latitude, longitude);

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    return Column(children: [
      Container(height: 1, color: ColorPallete.violetBlue),
      address == null ? Container() : row("assets/icons/common/pin.svg", address!.capitalizeEachWord),
      Container(height: 1, color: ColorPallete.violetBlue),
      phoneNumber == null ? Container() : rowPng("assets/icons/common/phone.png", phoneNumber!),
      Container(height: 1, color: ColorPallete.violetBlue),
      cost == null ? Container() : row("assets/icons/common/Parking.svg", "Парковка: бесплатно"),
      Container(height: 1, color: ColorPallete.violetBlue),
      !shouldShowHours() ? Container() : row("assets/icons/common/clock.svg", isOpen247! ? "Круглосуточно" : hours!),
      Container(height: 1, color: ColorPallete.violetBlue),
      description == null ? Container() : row("assets/icons/common/info.svg", description!),
      Container(height: 1, color: ColorPallete.violetBlue),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: SizedBox(
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
              ))),
      Container(height: 1, color: ColorPallete.violetBlue),
    ]);
  }

  Widget row(String assetPath, String text) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(children: [
          const SizedBox(width: 8),
          SvgColoredIcon(assetPath: assetPath, color: ColorPallete.violetBlue),
          const SizedBox(width: 8),
          Flexible(child: Text(text, maxLines: 2, style: TextStyle(fontSize: 16)))
        ]));
  }

  Widget rowPng(String assetPath, String text) {
    return Row(children: [
      const SizedBox(width: 8),
      Image.asset(assetPath, width: 30),
      const SizedBox(width: 8),
      Flexible(child: Text(text, maxLines: 2, style: TextStyle(fontSize: 16)))
    ]);
  }

  bool shouldShowHours() {
    if (isOpen247 == null) {
      return false;
    }
    if (!isOpen247! && hours == null) {
      return false;
    }
    return true;
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
