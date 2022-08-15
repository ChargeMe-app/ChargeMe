import 'package:chargeme/model/charging_place/station.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddStationViewModel extends ChangeNotifier {
  String id = const Uuid().v1();
  String _name = "";
  String _description = "";
  String _phoneNumber = "";
  String _address = "";
  Location? location;
  List<Station> _stations = [];

  String get name => _name;
  set name(String value) {
    _name = value;
    notifyListeners();
  }

  String get description => _description;
  set description(String value) {
    _description = value;
    notifyListeners();
  }

  String get phoneNumber => _phoneNumber;
  set phoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  String get address => _address;
  set address(String value) {
    _address = value;
    notifyListeners();
  }

  List<Station> get stations => _stations;
  void addEmptyStation() {
    final station = Station(id: const Uuid().v1(), locationId: id, available: 1, cost: 0, outlets: []);
    _stations.add(station);
    notifyListeners();
  }

  void addEmptyOutlet(int i, ConnectorType connectorType) {
    _stations[i].outlets.add(Outlet(id: const Uuid().v1(), available: 1, connectorType: connectorType));
    notifyListeners();
  }
}
