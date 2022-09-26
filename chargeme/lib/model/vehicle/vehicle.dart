import 'package:json_annotation/json_annotation.dart';
import 'package:chargeme/model/vehicle/vehicle_type.dart';

part 'vehicle.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Vehicle {
  String id;
  String? name;
  VehicleType type;

  Vehicle({required this.id, this.name, required this.type});

  factory Vehicle.fromJson(Map<String, dynamic> json) => _$VehicleFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}
