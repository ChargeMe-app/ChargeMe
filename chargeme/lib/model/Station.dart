class Station {
  String name;
  String? description;
  String? phoneNumber;
  String? address;
  Location location;
  List<StationType> stationTypes;
  Access? access;
  Cost? cost;
  Hours? hours;
  Amenities? amenities;
  bool isOpenOrActive;

  Station(
      {required this.name,
      this.description,
      this.phoneNumber,
      this.address,
      required this.location,
      required this.stationTypes,
      this.access,
      this.cost,
      this.hours,
      this.amenities,
      required this.isOpenOrActive});

  // factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  // Map<String, dynamic> toJson() => _$LatLngToJson(this);
}

class Location {
  double lat;
  double lng;

  Location({
    required this.lat,
    required this.lng,
  });
}

class Cost {
  bool isFeeRequired;
  String description;

  Cost({
    required this.isFeeRequired,
    required this.description,
  });
}

class Hours {
  bool isAlwaysOpened;
  String description;

  Hours({
    required this.isAlwaysOpened,
    required this.description,
  });
}

enum StationType { type1, type2, chademo, cssCombo }

enum Access { public, restrictes }

enum Amenities {
  lodging,
  dining,
  restrooms,
  evParking,
  valetParking,
  park,
  wifi,
  shopping,
  grocery,
  hiking,
  camping
}
