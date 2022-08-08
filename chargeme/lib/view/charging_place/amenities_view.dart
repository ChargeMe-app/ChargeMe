import 'package:chargeme/model/charging_place/station.dart';
import 'package:chargeme/view/charging_place/stations_list_view.dart';
import 'package:flutter/material.dart';

class AmenitiesView extends StatelessWidget {
  AmenitiesView({required this.amenities});

  List<Amenity> amenities;

  @override
  Widget build(BuildContext context) {
    return BoxWithTitle(
      title: "Amenities",
      children: List.generate(amenities.length, (i) {
        return Text(amenities[i].type.localizedTitle(context));
      }),
    );
  }
}
