import 'dart:convert';
import 'dart:io';

import 'package:chargeme/components/account_manager/account_manager.dart';
import 'package:chargeme/components/analytics_manager/analytics_manager.dart';
import 'package:chargeme/components/charging_place_manager/charging_place_manager.dart';
import 'package:chargeme/model/charging_place/charging_place.dart';
import 'package:chargeme/model/favourite_place/favourite_place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:chargeme/model/station_marker/station_marker.dart';

class ChargingPlaceViewModel extends ChangeNotifier {
  final AnalyticsManager analyticsManager;
  final AccountManager accountManager;
  late final ChargingPlaceManager _chargingPlaceManager = ChargingPlaceManager(analyticsManager: analyticsManager);

  List<FavouritePlace> favouritePlaces = [];

  BitmapDescriptor? icon;
  ChargingPlace? place;

  bool get isInFavourites {
    for (final favPlace in favouritePlaces) {
      if (favPlace.id == place?.id) return true;
    }
    return false;
  }

  ChargingPlaceViewModel({required this.analyticsManager, required this.accountManager}) {
    _initialSetup();
  }

  Future<void> _initialSetup() async {
    final file = await favouritesFile;
    try {
      final content = await file.readAsString();
      final decoded = jsonDecode(content) as List;
      favouritePlaces =
          List<FavouritePlace>.from(decoded.map((dynamic item) => FavouritePlace.fromJson(item)).toList());
      notifyListeners();
    } catch (error) {
      analyticsManager.logErrorEvent(error.toString());
      favouritePlaces = [];
    }
  }

  Future<File> get favouritesFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/favourite_places.json");
  }

  Future<void> loadPlace(String id) async {
    place = await _chargingPlaceManager.getChargingPlace(id: id);
    place?.reviews?.sort(((a, b) => b.createdAt.compareTo(a.createdAt))); // DO SORTING ON BACKEND
    if (place != null) {
      icon = await place!.iconType.getMarkerIcon();
    }
    notifyListeners();
  }

  void saveToFavourites() async {
    if (place == null) {
      return;
    }
    final favPlace =
        FavouritePlace(id: place!.id, name: place!.name, address: place!.address ?? "", iconType: place!.iconType);
    favouritePlaces.add(favPlace);
    notifyListeners();
    analyticsManager.logEvent("saved_to_favs", params: {"place_id": place!.id});
    final file = await favouritesFile;
    file.writeAsString(jsonEncode(favouritePlaces));
  }

  void removeFromFavourites() async {
    if (place == null) {
      return;
    }
    favouritePlaces.removeWhere((e) => e.id == place!.id);
    notifyListeners();
    analyticsManager.logEvent("removed_from_favs", params: {"place_id": place!.id});
    final file = await favouritesFile;
    file.writeAsString(jsonEncode(favouritePlaces));
  }
}

extension FavouritePlacesKey on String {
  static const String favouritePlacesKey = "favouritePlaces";
}
