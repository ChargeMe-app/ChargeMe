import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:chargeme/view_model/add_station_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeAmenitiesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Change amenities"),
          backgroundColor: ColorPallete.violetBlue,
        ),
        body: ListView(children: [
          SizedBox(height: 12),
          Text("Choose amenities present on this location",
              textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Container(height: 0.5, color: ColorPallete.violetBlue),
          Consumer<AddStationViewModel>(
              builder: (context, addStationVM, child) => Column(
                      children: List.generate(AmenityType.values.length, (i) {
                    final amenityType = AmenityType.values[i];
                    final isSelected = addStationVM.amenities.contains(amenityType);
                    return Container(
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 0.5, color: ColorPallete.violetBlue))),
                        child: ListTile(
                            title: Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
                              SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: Image.asset(amenityType.icon,
                                      color: isSelected ? ColorPallete.violetBlue : null)),
                              const SizedBox(width: 8),
                              Text(amenityType.localizedTitle(context))
                            ]),
                            trailing: isSelected
                                ? SizedBox(width: 24, child: Icon(CupertinoIcons.check_mark))
                                : Container(width: 24),
                            selected: isSelected,
                            selectedColor: ColorPallete.violetBlue,
                            onTap: () {
                              if (isSelected) {
                                addStationVM.removeAmenity(amenityType);
                              } else {
                                addStationVM.addAmenity(amenityType);
                              }
                            }));
                  })))
        ]));
  }
}
