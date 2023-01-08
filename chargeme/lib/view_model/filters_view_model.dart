import 'dart:convert';
import 'dart:io';

import 'package:chargeme/components/analytics_manager/analytics_manager.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:chargeme/model/filters/filters.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FiltersViewModel extends ChangeNotifier {
  Filters _filters = Filters(connectors: ConnectorType.values.toSet());
  AnalyticsManager _analyticsManager;
  late final SharedPreferences _prefs;

  FiltersViewModel({required AnalyticsManager analyticsManager}) : _analyticsManager = analyticsManager {
    initialSetup();
  }

  void switchConnectorType(ConnectorType value) {
    if (_filters.connectors.contains(value)) {
      _filters.connectors.remove(value);
    } else {
      _filters.connectors.add(value);
    }
    notifyListeners();
  }

  void deselectConnectors() {
    _filters.connectors = Set();
    notifyListeners();
  }

  void setScoreRange(RangeValues values) {
    _filters.minScore = values.start;
    _filters.maxScore = values.end;
    notifyListeners();
  }

  Set<ConnectorType> get connectors => _filters.connectors;
  double get minScore => _filters.minScore;
  double get maxScore => _filters.maxScore;

  bool get showPublic => _filters.showPublic;
  set showPublic(bool value) {
    _filters.showPublic = value;
    notifyListeners();
  }

  bool get showPublicFast => _filters.showPublicFast;
  set showPublicFast(bool value) {
    _filters.showPublicFast = value;
    notifyListeners();
  }

  bool get showHome => _filters.showHome;
  set showHome(bool value) {
    _filters.showHome = value;
    notifyListeners();
  }

  bool get showPaid => _filters.showPaid;
  set showPaid(bool value) {
    _filters.showPaid = value;
    notifyListeners();
  }

  bool get showComingSoon => _filters.showComingSoon;
  set showComingSoon(bool value) {
    _filters.showComingSoon = value;
    notifyListeners();
  }

  bool get showWithCheckin => _filters.showWithCheckin;
  set showWithCheckin(bool value) {
    _filters.showWithCheckin = value;
    notifyListeners();
  }

  void reset() {
    _filters.connectors = ConnectorType.values.toSet();
    _filters.minScore = 0;
    _filters.maxScore = 10;
    _filters.showPublic = true;
    _filters.showPublicFast = true;
    _filters.showHome = true;
    _filters.showComingSoon = true;
    _filters.showPaid = true;
    _filters.showWithCheckin = true;
    notifyListeners();
  }

  void apply(Filters filters) {
    _filters = filters;
    notifyListeners();
  }
}

extension FiltersStorage on FiltersViewModel {
  Future<File> get storedFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/filters/$_filename.json");
  }

  void initialSetup() async {
    _prefs = await SharedPreferences.getInstance();
    File file = await storedFile;
    file.create(recursive: true);
    try {
      final contents = await file.readAsString();
      final json = jsonDecode(contents);
      Filters filters = Filters.fromJson(json);
      apply(filters);
    } catch (error) {
      _analyticsManager.logErrorEvent(error.toString());
    }
  }

  void save() async {
    (await storedFile).writeAsString(jsonEncode(_filters));
    _prefs.setBool("shouldReloadFilters", true);
  }
}

String _filename = "saved_filters";
