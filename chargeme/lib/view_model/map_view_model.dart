import 'dart:convert';
import 'dart:io';

import 'package:chargeme/components/account_manager/account_manager.dart';
import 'package:chargeme/components/analytics_manager/analytics_manager.dart';
import 'package:chargeme/components/helpers/throttler.dart';
import 'package:chargeme/components/markers_manager/markers_manager.dart';
import 'package:chargeme/gen/l10n.dart';
import 'package:chargeme/model/station_marker/station_marker.dart';
import 'package:chargeme/view/map/marker_info_view.dart';
import 'package:chargeme/view_model/search_view_model.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapViewModel extends ChangeNotifier {
  final MarkersManager markersManager;
  final AccountManager accountManager;
  final AnalyticsManager analyticsManager;
  final SearchViewModel searchVM;

  final Map<String, Marker> _markers = {};
  final Map<String, Marker> _permanentMarkers = {};
  final Map<IconType, BitmapDescriptor> _cachedMarkerIcons = {};

  bool _isSearchEnabled = false;
  bool isLoading = false;
  bool showFilters = false;
  Map<String, Marker> get markers => _markers;

  final Throttler _throttler = Throttler();
  late final SharedPreferences _prefs;

  String? _filtersString;

  final CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();
  CustomInfoWindowController get customInfoWindowController => _customInfoWindowController;
  GoogleMapController? get _mapController {
    return _customInfoWindowController.googleMapController;
  }

  MapViewModel(
      {required this.markersManager,
      required this.accountManager,
      required this.analyticsManager,
      required this.searchVM}) {
    initialSetup();
  }

  void initialSetup() async {
    _prefs = await SharedPreferences.getInstance();
    showFilters = _prefs.getBool("filters") ?? false;
    notifyListeners();
    _setupCachedMarkerIcons();
    _loadFilters();
  }

  bool get isSearchEnabled => _isSearchEnabled;
  set isSearchEnabled(bool value) {
    _isSearchEnabled = value;
    if (_isSearchEnabled) {
      searchVM.focusNode.requestFocus();
    }
    notifyListeners();
  }

  Future<void> _setupCachedMarkerIcons() async {
    for (var v in IconType.values) {
      final icon = await v.getMarkerIcon();
      if (icon != null) {
        _cachedMarkerIcons[v] = icon;
      }
    }
  }

  void _loadFilters() async {
    final shouldReload = _prefs.getBool("shouldReloadFilters") ?? false;
    if (!shouldReload) {
      return;
    }
    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/filters/saved_filters.json");
    _filtersString = await file.readAsString();
    _prefs.setBool("shouldReloadFilters", false);
  }

  void onMapCreated(GoogleMapController controller) {
    _customInfoWindowController.googleMapController = controller;
    moveCameraToCurrentLocation();
  }

  Future<void> moveCameraToCurrentLocation() async {
    try {
      final Position userLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _mapController?.animateCamera(CameraUpdate.newLatLng(LatLng(userLocation.latitude, userLocation.longitude)));
    } catch (error) {
      analyticsManager.logErrorEvent(error.toString());
    }
  }

  Future<void> updateMarkers(LatLngBounds region) async {
    final stationMarkers = await markersManager.getStationMarkers(bounds: region);

    _markers.clear();
    for (final markerKey in _permanentMarkers.keys) {
      _markers[markerKey] = _permanentMarkers[markerKey]!;
    }
    for (final stationMarker in stationMarkers) {
      String stationTypes =
          stationMarker.stations.map((e) => e.outlets.map((e) => e.connector.str).join(", ")).join(", ");
      LatLng latLng = LatLng(stationMarker.latitude, stationMarker.longitude);
      var markerIcon = _cachedMarkerIcons[stationMarker.iconType];
      final marker = Marker(
          consumeTapEvents: true,
          icon: markerIcon ?? BitmapDescriptor.defaultMarker,
          markerId: MarkerId(stationMarker.id.toString()),
          position: LatLng(stationMarker.latitude, stationMarker.longitude),
          onTap: () {
            analyticsManager.logEvent("marker_tap", params: {"place_id": stationMarker.id});
            _customInfoWindowController.addInfoWindow!(
                MarkerInfoView(
                    stationMarker.id,
                    stationMarker.iconType == IconType.home ? L10n.homeCharger.str : stationMarker.name,
                    stationTypes,
                    markerIcon,
                    stationMarker.score,
                    analyticsManager: analyticsManager,
                    accountManager: accountManager),
                latLng);
          });
      _markers[stationMarker.id.toString()] = marker;
    }

    isLoading = false;
    notifyListeners();
  }

  void processLongPress(LatLng latLng) {
    _markers["123"] = Marker(
        consumeTapEvents: true,
        markerId: const MarkerId("123"),
        position: latLng,
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
              MarkerInfoView("213995", "Station #1", "Cool station", null, 8.6,
                  analyticsManager: analyticsManager, accountManager: accountManager),
              latLng);
        });
    notifyListeners();
  }

  void processTap(LatLng latLng) {
    searchVM.resetResults();
    _customInfoWindowController.hideInfoWindow!();
  }

  void processCameraMove(CameraPosition position) {
    searchVM.resetResults();
    _customInfoWindowController.onCameraMove!();

    if (_customInfoWindowController.googleMapController != null) {
      _throttler.throttle(const Duration(milliseconds: 500), () async {
        final LatLngBounds region = await _customInfoWindowController.googleMapController!.getVisibleRegion();
        updateMarkers(region);
        isLoading = true;
        notifyListeners();
      });
    }
  }

  void processSearchResultTap(SearchResult searchResult) {
    if (searchResult.type == SearchResultType.address) {
      _permanentMarkers["searchResult"] = Marker(markerId: const MarkerId("123132"), position: searchResult.location);
    }
    _customInfoWindowController.googleMapController!
        .moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: searchResult.location, zoom: 14.0)));
  }
}
