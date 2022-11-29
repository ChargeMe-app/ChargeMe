class YandexOrganizations {
  List<Feature> features;

  YandexOrganizations({required this.features});
}

class Feature {
  String type;
  Geometry geometry;
  List<OrganizationProperty>? properties;
  String? description;
  String? name;

  Feature({required this.type, required this.geometry, this.properties, this.description, this.name});
}

class Geometry {
  String type;
  List<double> coordinates;

  Geometry({required this.type, required this.coordinates});
}

class OrganizationProperty {}

class CompanyMetadata {
  String id;
  String name;
  String? address;
  String? url;
  // List<CompanyCategory>? categories;

  CompanyMetadata({required this.id, required this.name, this.address, this.url});
}

// class CompanyCategory {
//   String name;
// }
