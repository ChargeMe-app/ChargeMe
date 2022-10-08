import 'package:chargeme/gen/l10n.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:chargeme/view/charging_place/stations_list_view.dart';
import 'package:flutter/material.dart';

class AmenitiesView extends StatelessWidget {
  AmenitiesView({required this.amenities});

  List<Amenity> amenities;

  @override
  Widget build(BuildContext context) {
    return BoxWithTitle(
      title: L10n.amenities.str,
      children: List.generate(amenities.length, (i) {
        return Padding(
            padding: EdgeInsets.all(4),
            child: Row(children: [
              Container(width: 32, height: 32, child: Image.asset(amenities[i].form.icon)),
              const SizedBox(width: 8),
              Text(amenities[i].form.localizedTitle),
              Spacer()
            ]));
      }),
    );
  }
}
