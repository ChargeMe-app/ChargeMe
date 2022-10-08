import 'package:chargeme/extensions/color_pallete.dart';
import 'package:chargeme/gen/assets.dart';
import 'package:chargeme/view/charging_place/charging_place_view.dart';
import 'package:chargeme/view_model/charging_place_view_model.dart';
import 'package:chargeme/model/station_marker/station_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class FavouritePlacesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChargingPlaceViewModel>(builder: (context, chargingPlaceVM, child) {
      return Scaffold(
          appBar: AppBar(title: Text("Favourites"), backgroundColor: ColorPallete.violetBlue),
          body: chargingPlaceVM.favouritePlaces.isEmpty
              ? const Center(
                  child: Text("The list is empty.\nBrowse map to find places and add them to favourites",
                      textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)))
              : SingleChildScrollView(
                  child: Column(
                      children: List.generate(chargingPlaceVM.favouritePlaces.length, (i) {
                  final favPlace = chargingPlaceVM.favouritePlaces[i];
                  return ListTile(
                    leading: Image.asset(
                      favPlace.iconType.assetPath,
                      height: 42,
                    ),
                    title: Text(favPlace.name,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    subtitle: Text(favPlace.address, maxLines: 1, overflow: TextOverflow.clip),
                    trailing: SvgPicture.asset(Asset.chevronRight.path),
                    onTap: () {
                      context.read<ChargingPlaceViewModel>().loadPlace(favPlace.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChargingPlaceView()),
                      );
                    },
                  );
                }))));
    });
  }
}
