import 'dart:convert';

import 'package:chargeme/components/account_manager/account_manager.dart';
import 'package:chargeme/components/analytics_manager/analytics_manager.dart';
import 'package:chargeme/components/constants/constants.dart';
import 'package:chargeme/model/account/account.dart';
import 'package:chargeme/model/vehicle/vehicle.dart';
import 'package:chargeme/model/vehicle/vehicle_type.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chargeme/components/helpers/ip.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension PreferredVehicleKey on String {
  static const preferredVehicleIdKey = "preferredVehicleId";
  static const preferredVehiceTypeKey = "preferredVehiceType";
}

class ChooseVehicleViewModel extends ChangeNotifier with AccountManagerObserver {
  final AccountManager _accountManager;
  final AnalyticsManager _analyticsManager;
  late SharedPreferences? _prefs;

  int? _shownManufacturerIndex;
  Vehicle? _chosenVehicle;
  VehicleType? _vehicleTypeToChoose;

  double rotation = 0.0;
  bool _isEditMode = false;
  bool _onlyChoosing = false;

  List<Vehicle> get vehicles {
    return _accountManager.currentAccount?.vehicles ?? [];
  }

  ChooseVehicleViewModel(this._accountManager, this._analyticsManager) {
    initialSetup();
  }

  Future<void> initialSetup() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      String? id = _prefs?.getString(preferredVehicleIdKey);
      VehicleType vehicleType = VehicleType.values.firstWhere((e) => e.value == _prefs?.getInt(preferredVehiceTypeKey));

      if (id != null && vehicleType != VehicleType.unknown) {
        chosenVehicle = Vehicle(id: id, type: vehicleType);
      }

      _accountManager.addObserver(this);
    } catch (error) {
      _analyticsManager.logErrorEvent(error.toString());
    }
  }

  @override
  void dispose() {
    _accountManager.removeObserver(this);
    super.dispose();
  }

  @override
  void currentAccountUpdated(Account account) {
    if ((account.vehicles ?? []).contains(chosenVehicle)) {
      removePreferredVehicle();
    }
  }

  int? get shownManufacturerIndex => _shownManufacturerIndex;
  set shownManufacturerIndex(int? value) {
    _shownManufacturerIndex = value;
    if (value == null) {
      rotation = 0.0;
    } else {
      rotation = 4.0 / 8.0;
    }
    notifyListeners();
  }

  Vehicle? get chosenVehicle => _chosenVehicle;
  set chosenVehicle(Vehicle? value) {
    _chosenVehicle = value;
    notifyListeners();
  }

  VehicleType? get vehicleTypeToChoose => _vehicleTypeToChoose;
  set vehicleTypeToChoose(VehicleType? value) {
    _vehicleTypeToChoose = value;
    notifyListeners();
  }

  bool get isEditMode => _isEditMode;
  set isEditMode(bool value) {
    _isEditMode = value;
    notifyListeners();
  }

  bool get onlyChoosing => _onlyChoosing;
  set onlyChoosing(bool value) {
    _onlyChoosing = value;
    notifyListeners();
  }

  Future<void> setChosenVehicleType({bool shouldSelect = false}) async {
    if (_accountManager.currentAccount == null || vehicleTypeToChoose == null) return;
    Map<String, dynamic> postBody = {
      "user_id": _accountManager.currentAccount!.id,
      "vehicle_type": vehicleTypeToChoose?.value,
    };
    try {
      final response = await http.post(Uri.parse("http://${IP.current}/v1/user/vehicle"), body: jsonEncode(postBody));
      if (response.statusCode == 200) {
        _analyticsManager.logEvent("successful vehicle type chosen");
        await _accountManager.updateAccountInfo();
        if (shouldSelect && vehicles.isNotEmpty) {
          savePreferredVehicle(vehicles[0]);
        }
        notifyListeners();
      }
    } catch (error) {
      _analyticsManager.logErrorEvent(error.toString());
    }
  }

  Future<void> savePreferredVehicle(Vehicle vehicle) async {
    chosenVehicle = vehicle;
    await _prefs?.setInt(preferredVehiceTypeKey, vehicle.type.value);
    await _prefs?.setString(preferredVehicleIdKey, vehicle.id);
    notifyListeners();
  }

  Future<void> removePreferredVehicle() async {
    chosenVehicle = null;
    await _prefs?.remove(preferredVehiceTypeKey);
    await _prefs?.remove(preferredVehicleIdKey);
    notifyListeners();
  }

  Future<void> removeVehicle(Vehicle vehicle) async {
    if (_accountManager.currentAccount == null) return;
    Map<String, dynamic> postBody = {
      "user_id": _accountManager.currentAccount!.id,
      "id": vehicle.id,
    };
    try {
      final response = await http.delete(Uri.parse("http://${IP.current}/v1/user/vehicle"), body: jsonEncode(postBody));
      if (response.statusCode == 200) {
        _analyticsManager.logEvent("successful vehicle type removed");
        await _accountManager.updateAccountInfo();
        notifyListeners();
      }
    } catch (error) {
      _analyticsManager.logErrorEvent(error.toString());
    }
  }
}
