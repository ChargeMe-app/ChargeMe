import 'package:flutter/material.dart';
import 'package:chargeme/model/charging_place/charging_place.dart';

class PlaceScoreView extends StatelessWidget {
  final double? score;

  PlaceScoreView({required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: score?.bgColor, borderRadius: BorderRadius.all(Radius.circular(4))),
        child: score == null
            ? Container()
            : Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  score!.beautifulScore,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                )));
  }
}
