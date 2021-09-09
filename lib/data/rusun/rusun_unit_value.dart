import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'rusun_unit_value.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
@Entity()
class RusunUnitValue {
  RusunUnitValue({
    required this.unitId,
    required this.rusunId,
    required this.buildingId,
    required this.floor,
    required this.code,
    required this.unitNumber,
    required this.unitStatus,
    required this.plnNumber,
    required this.pdamNumber,
    required this.plnMeterStatus,
    required this.pdamMeterStatus,
    required this.firstMeterValue,
    required this.lastMeterValue,
    required this.meterPostDtime,
    required this.month,
    required this.year,
  });

  @Id()
  int? id;
  @Index()
  final int unitId;
  @Index()
  final int rusunId;
  @Index()
  final int buildingId;
  @Index()
  final int floor;
  @Index()
  final String code;
  @Index()
  final String unitNumber;
  final String unitStatus;
  final String plnNumber;
  final String pdamNumber;
  int plnMeterStatus;
  int pdamMeterStatus;
  final double? firstMeterValue;
  double? lastMeterValue;
  DateTime? meterPostDtime;
  final int month;
  final int year;

  factory RusunUnitValue.fromJson(Map<String, dynamic> json) =>
      _$RusunUnitValueFromJson(json);

  Map<String, dynamic> toJson() => _$RusunUnitValueToJson(this);
  
  bool get inputDone => meterPostDtime != null;
}
