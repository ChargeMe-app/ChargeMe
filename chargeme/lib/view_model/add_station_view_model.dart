import 'dart:convert';

import 'package:chargeme/components/analytics_manager/analytics_manager.dart';
import 'package:chargeme/components/helpers/limitator.dart';
import 'package:chargeme/gen/company.dart';
import 'package:chargeme/model/charging_place/charging_place.dart';
import 'package:chargeme/model/charging_place/station.dart';
import 'package:chargeme/components/helpers/ip.dart';
import 'package:chargeme/model/station_marker/station_marker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class AddStationViewModel extends ChangeNotifier {
  final AnalyticsManager analyticsManager;
  final Limitator limitator = LimitatorCooldown();

  bool isEditingLocationMode = false;
  bool isHomeCharger = false;

  String id = "0";
  String _name = "";
  String _description = "";
  String _phoneNumber = "";
  String _address = "";
  Location? location;
  List<Station> _stations = [];
  Company? _company;
  Access _access = Access.public;
  bool _requiresFee = false;
  String _costDescription = "";
  bool _isOpen247 = true;
  String _hours = "";
  List<Amenity> _amenities = [];
  bool _isOpenOrActive = true;

  AddStationViewModel({required this.analyticsManager});

  void setupForEditing(ChargingPlace place) {
    id = place.id;
    _name = place.name;
    _description = place.description ?? "";
    _phoneNumber = place.phoneNumber ?? "";
    _address = place.address ?? "";
    location = Location(lat: place.latitude, lng: place.longitude);
    _stations = place.stations;
    _company = place.companyName;
    // _access = place.access ?? Access.public;
    _requiresFee = place.cost ?? false;
    _costDescription = place.costDescription ?? "";
    _isOpen247 = place.open247 ?? false;
    _hours = place.hours ?? "";
    _amenities = place.amenities ?? [];
    _isOpenOrActive = !(place.comingSoon ?? false);

    isEditingLocationMode = true;
  }

  void resetModel() {
    id = "0";
    _name = "";
    _description = "";
    _phoneNumber = "";
    _address = "";
    location = null;
    _stations = [];
    _company = null;
    _access = Access.public;
    _requiresFee = false;
    _costDescription = "";
    _isOpen247 = true;
    _hours = "";
    _amenities = [];
    _isOpenOrActive = true;

    isEditingLocationMode = false;
    isHomeCharger = false;
    notifyListeners();
  }

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

  Company? get company => _company;
  set company(Company? value) {
    _company = value;
    notifyListeners();
  }

  Access get access => _access;
  set access(Access value) {
    _access = value;
    _isOpenOrActive = value == Access.public;
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

  IconType calculateIconType() {
    if (isHomeCharger) {
      return IconType.home;
    }
    IconType iconType = IconType.publicStandard;
    for (final station in _stations) {
      for (final outlet in station.outlets) {
        if (outlet.connectorType == ConnectorType.chademo ||
            outlet.connectorType == ConnectorType.cssCombo ||
            outlet.connectorType == ConnectorType.teslaRoadster) {
          iconType = IconType.publicFast;
        }
      }
    }
    if (!isOpenOrActive) {
      if (iconType == IconType.publicFast) {
        iconType = IconType.repairFast;
      }
      if (iconType == IconType.publicStandard) {
        iconType = IconType.repairStandard;
      }
    }
    return iconType;
  }

  bool isAbleToCreate() {
    if (name.isNotEmpty && location != null && stations.isNotEmpty) return true;
    return false;
  }

  void createLocation() {
    if (!isAbleToCreate()) return;
    final place = ChargingPlace(
      id: id,
      name: name,
      iconType: calculateIconType(),
      description: description,
      phoneNumber: phoneNumber,
      address: address,
      latitude: location!.lat,
      longitude: location!.lng,
      photos: [],
      reviews: [],
      stations: stations,
      access: access == Access.restricted ? 1 : 0,
      cost: requiresFee,
      costDescription: costDescription,
      open247: isOpen247,
      hours: hours,
      amenities: _amenities,
      comingSoon: !isOpenOrActive,
    );
    limitator.tryExec(() {
      sendLocation(place);
    });
  }

  void sendLocation(ChargingPlace place) async {
    String encodedJson = jsonEncode(place);
    try {
      if (isEditingLocationMode) {
        await http.put(Uri.parse("http://${IP.current}/v1/locations"), body: encodedJson);
      } else {
        await http.post(Uri.parse("http://${IP.current}/v1/locations"), body: encodedJson);
      }
    } catch (error) {
      analyticsManager.logErrorEvent(error.toString());
    }
  }
}
