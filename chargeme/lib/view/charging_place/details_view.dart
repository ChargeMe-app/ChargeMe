import 'package:chargeme/view/charging_place/stations_list_view.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:chargeme/extensions/string_extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailsView extends StatelessWidget {
  DetailsView({required this.latitude, required this.longitude, this.icon, this.address, this.phoneNumber});

  final double latitude;
  final double longitude;
  final BitmapDescriptor? icon;
  final String? address;
  final String? phoneNumber;
  LatLng get latLng => LatLng(latitude, longitude);

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    return BoxWithTitle(title: l10n.details, footer: l10n.getDirections, children: [
      address == null ? Container() : row(Icons.location_pin, address!.capitalizeEachWord),
      const SizedBox(height: 8),
      phoneNumber == null ? Container() : row(Icons.phone_iphone, phoneNumber!),
      const SizedBox(height: 8),
      SizedBox(
          height: 100,
          child: GoogleMap(
            myLocationButtonEnabled: false,
            markers: {
              Marker(markerId: const MarkerId("123"), icon: icon ?? BitmapDescriptor.defaultMarker, position: latLng)
            },
            initialCameraPosition: CameraPosition(
              target: latLng,
              zoom: 13.0,
            ),
          )),
      const SizedBox(height: 8),
    ]);
  }

  Widget row(IconData iconData, String text) {
    return Row(
        children: [Icon(iconData, size: 36), Flexible(child: Text(text, maxLines: 2, style: TextStyle(fontSize: 16)))]);
  }
}
