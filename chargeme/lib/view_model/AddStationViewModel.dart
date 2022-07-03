import 'package:chargeme/model/Station.dart';
import 'package:flutter/material.dart';

class AddStationViewModel extends ChangeNotifier {
  String _name = "";
  String _description = "";
  String _phoneNumber = "";
  String _address = "";
  Location? location;
  List<StationType> stationTypes = [];

  String get name => _name;
  void set name(String value) {
    _name = value;
    notifyListeners();
  }

  String get description => _description;
  void set description(String value) {
    _description = value;
    notifyListeners();
  }

  String get phoneNumber => _phoneNumber;
  void set phoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  String get address => _address;
  void set address(String value) {
    _address = value;
    notifyListeners();
  }
}
