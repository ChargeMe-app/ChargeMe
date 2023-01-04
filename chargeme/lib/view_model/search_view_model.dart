import 'package:chargeme/components/analytics_manager/analytics_manager.dart';
import 'package:chargeme/components/helpers/throttler.dart';
import 'package:chargeme/components/markers_manager/markers_manager.dart';
import 'package:chargeme/components/place_searcher/place_searcher.dart';
import 'package:chargeme/model/station_marker/station_marker.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:chargeme/extensions/placemark_extensions.dart';
import 'package:async/async.dart';

enum SearchResultType { chargingPlace, address }

class SearchResult {
  final String title;
  final String? subtitle;
  final LatLng location;
  final SearchResultType type;
  final IconType? iconType;

  SearchResult({required this.title, this.subtitle, required this.location, required this.type, this.iconType});
}

const placeSearchOffset = 0.01; // 1 lat (long) = 111 km

class SearchViewModel extends ChangeNotifier {
  List<SearchResult> _results = [];
  List<SearchResult> get results => _results;
  final MarkersManager markersManager;
  final AnalyticsManager analyticsManager;
  final List<CancelableOperation> _cancelables = [];

  late final PlaceSearcher _placeSearcher = PlaceSearcher();
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  Throttler throttler = Throttler();

  SearchViewModel({required this.analyticsManager, required this.markersManager});

  Future<void> fetchResults(String query) async {
    resetResults();
    try {
      // final List<String> res = await _placeSearcher.getOrganizations(text: query);
      final List<Location> result = await locationFromAddress(query);

      for (final entry in result) {
        final operation = CancelableOperation.fromFuture(markersManager.getStationMarkers(
            bounds: LatLngBounds(
                southwest: LatLng(entry.latitude - placeSearchOffset, entry.longitude - placeSearchOffset),
                northeast: LatLng(entry.latitude + placeSearchOffset, entry.longitude + placeSearchOffset))));

        _cancelables.add(operation);

        operation.value.then((markers) {
          markers.forEach((e) {
            _results.add(SearchResult(
                title: e.name,
                subtitle: e.address,
                location: LatLng(e.latitude, e.longitude),
                type: SearchResultType.chargingPlace,
                iconType: e.iconType));
          });
          notifyListeners();
        });
      }

      for (final entry in result) {
        final operation = CancelableOperation.fromFuture(
            placemarkFromCoordinates(entry.latitude, entry.longitude, localeIdentifier: "ru_RU"));

        _cancelables.add(operation);

        operation.value.then((placemarks) {
          placemarks.forEach((e) {
            _results.add(SearchResult(
                title: "Location",
                subtitle: e.fullAddress,
                location: LatLng(entry.latitude, entry.longitude),
                type: SearchResultType.address));
          });
          notifyListeners();
        });
      }
    } catch (error) {
      analyticsManager.logErrorEvent(error.toString());
    }
  }

  void clearCancellables() {
    for (var i = 0; i < _cancelables.length; i++) {
      _cancelables[i].cancel();
      _cancelables.removeAt(i);
    }
  }

  void resetResults() {
    _results = [];
    clearCancellables();
    notifyListeners();
  }
}
