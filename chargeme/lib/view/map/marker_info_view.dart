import 'package:chargeme/extensions/color_pallete.dart';
import 'package:flutter/material.dart';

class MarkerInfoView extends StatelessWidget {
  final String title;
  final String subtitle;
  final double? score;

  MarkerInfoView(this.title, this.subtitle, this.score);

  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 4)]),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
                decoration:
                    const BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(4))),
                child: score == null
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.all(6),
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
              onTap: () {},
            )
          ]),
        ));
  }
}
