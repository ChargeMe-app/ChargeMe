import 'package:geocoding/geocoding.dart';

extension AddressFromPlacemark on Placemark {
  String get fullAddress {
    return "$street $locality $subLocality, $country";
  }
}
