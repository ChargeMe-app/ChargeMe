import 'package:chargeme/model/charging_place/station.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class AddStationViewModel extends ChangeNotifier {
  String id = const Uuid().v1();
  String _name = "";
  String _description = "";
  String _phoneNumber = "";
  String _address = "";
  Location? location;
  List<Station> _stations = [];
  Access _access = Access.public;
  bool _requiresFee = false;
  String _costDescription = "";
  bool _isOpen247 = true;
  String _hours = "";
  List<Amenity> _amenities = [];
  bool _isOpenOrActive = true;

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

  void setLocation(String? address, LatLng latlng) {
    if (address != null) _address = address;
    location = Location(lat: latlng.latitude, lng: latlng.longitude);
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

  void removeOutlet(int stationIndex, int connectorIndex) {
    _stations[stationIndex].outlets.removeAt(connectorIndex);
    notifyListeners();
  }

  void removeStation(int i) {
    _stations.removeAt(i);
    notifyListeners();
  }

  Access get access => _access;
  set access(Access value) {
    _access = value;
    notifyListeners();
  }

  bool get requiresFee => _requiresFee;
  set requiresFee(bool value) {
    _requiresFee = value;
    notifyListeners();
  }

  String get costDescription => _costDescription;
  set costDescription(String value) {
    _costDescription = value;
    notifyListeners();
  }

  bool get isOpen247 => _isOpen247;
  set isOpen247(bool value) {
    _isOpen247 = value;
    notifyListeners();
  }

  String get hours => _hours;
  set hours(String value) {
    _hours = value;
    notifyListeners();
  }

  List<AmenityType> get amenities => _amenities.map((e) => e.form).toList();
  void addAmenity(AmenityType amenityType) {
    _amenities.add(Amenity(locationId: id, form: amenityType));
    notifyListeners();
  }

  void removeAmenity(AmenityType amenityType) {
    _amenities.removeWhere((element) => element.form == amenityType);
    notifyListeners();
  }

  bool get isOpenOrActive => _isOpenOrActive;
  set isOpenOrActive(bool value) {
    _isOpenOrActive = value;
    notifyListeners();
  }

  bool isAbleToCreate() {
    if (name.isNotEmpty && location != null && stations.isNotEmpty) return true;
    return false;
  }
}
