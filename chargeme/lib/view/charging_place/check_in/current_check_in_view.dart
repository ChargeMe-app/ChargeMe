import 'package:chargeme/gen/assets.dart';
import 'package:chargeme/gen/l10n.dart';
import 'package:chargeme/model/charging_place/charging_place.dart';
import 'package:chargeme/model/vehicle/vehicle_type.dart';
import 'package:chargeme/extensions/datetime_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CurrentCheckInView extends StatelessWidget {
  CheckIn checkIn;

  CurrentCheckInView({required this.checkIn});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(4),
        child: Row(children: [
          SvgPicture.asset(Asset.checkmarkRounded.path, height: 24),
          const SizedBox(width: 8),
          Flexible(
              child: RichText(
                  text: TextSpan(style: TextStyle(fontSize: 16, color: Colors.black), children: [
            TextSpan(text: checkIn.userName, style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: " " + L10n.isCheckedInHere.str),
            checkIn.vehicleType == null ? TextSpan() : TextSpan(text: " " + L10n.withWord.str + " "),
            checkIn.vehicleType == null
                ? TextSpan()
                : TextSpan(text: checkIn.vehicleType!.fullName, style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: " " + L10n.forNext.str + " "),
            TextSpan(text: checkIn.finishesAt.remainingTime, style: TextStyle(fontWeight: FontWeight.bold)),
            checkIn.comment.isEmpty
                ? TextSpan()
                : TextSpan(text: "\n" + checkIn.comment, style: TextStyle(fontStyle: FontStyle.italic))
          ])))
        ]));
  }
}
