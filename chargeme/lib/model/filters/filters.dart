import 'package:chargeme/model/charging_place/station.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filters.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Filters {
  Set<ConnectorType> connectors = ConnectorType.values.toSet();
  double minScore = 0;
  double maxScore = 10;
  bool showPublic = true;
  bool showPublicFast = true;
  bool showHome = true;
  bool showComingSoon = true;
  bool showPaid = true;
  bool showWithCheckin = true;

  Filters(
      {required this.connectors,
      this.minScore = 0,
      this.maxScore = 10,
      this.showPublic = true,
      this.showPublicFast = true,
      this.showHome = true,
      this.showComingSoon = true,
      this.showPaid = true,
      this.showWithCheckin = true});

  factory Filters.fromJson(Map<String, dynamic> json) => _$FiltersFromJson(json);
  Map<String, dynamic> toJson() => _$FiltersToJson(this);
}
