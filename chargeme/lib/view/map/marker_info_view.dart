import 'package:chargeme/components/account_manager/account_manager.dart';
import 'package:chargeme/components/analytics_manager/analytics_manager.dart';
import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/view/charging_place/charging_place_view.dart';
import 'package:chargeme/view/common/place_score_view.dart';
import 'package:chargeme/view_model/charging_place_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

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
        child: GestureDetector(
            onTap: () {
              context.read<ChargingPlaceViewModel>().loadPlace(placeId);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChargingPlaceView()),
              );
            },
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 4)]),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    PlaceScoreView(score: score),
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
                    Icon(Icons.info_outline, color: ColorPallete.darkerBlue),
                  ]),
                ))),
        builder: (BuildContext context, double opacity, Widget? child) {
          return Opacity(opacity: opacity, child: child);
        });
  }
}
