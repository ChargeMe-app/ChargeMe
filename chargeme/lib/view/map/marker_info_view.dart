import 'package:chargeme/components/account_manager/account_manager.dart';
import 'package:chargeme/components/analytics_manager/analytics_manager.dart';
import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/view/charging_place/charging_place_view.dart';
import 'package:flutter/material.dart';
import 'package:chargeme/model/charging_place/charging_place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerInfoView extends StatelessWidget {
  final String placeId;
  final String title;
  final String subtitle;
  final BitmapDescriptor? icon;
  final double? score;
  final AnalyticsManager analyticsManager;
  final AccountManager accountManager;

  MarkerInfoView(this.placeId, this.title, this.subtitle, this.icon, this.score,
      {required this.analyticsManager, required this.accountManager});

  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        curve: Curves.ease,
        duration: const Duration(milliseconds: 500),
        child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 4)]),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                    decoration:
                        BoxDecoration(color: score?.bgColor, borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: score == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              score!.toInt() == score ? score!.toInt().toString() : score.toString(),
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ))),
                score == null ? Container() : const SizedBox(width: 8),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      constraints: BoxConstraints(maxWidth: score == null ? 190 : 142),
                      child: Text(title,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
                  Container(
                      constraints: BoxConstraints(maxWidth: score == null ? 190 : 142),
                      child: Text(subtitle,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(color: Colors.grey, fontSize: 12)))
                ]),
                const Spacer(),
                GestureDetector(
                  child: Icon(Icons.info_outline, color: ColorPallete.darkerBlue),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChargingPlaceView(
                              id: placeId,
                              icon: icon,
                              analyticsManager: analyticsManager,
                              accountManager: accountManager),
                        ));
                  },
                )
              ]),
            )),
        builder: (BuildContext context, double opacity, Widget? child) {
          return Opacity(opacity: opacity, child: child);
        });
  }
}
