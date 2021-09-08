import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'rusun_unit.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
@Entity()
class RusunUnit {
  RusunUnit({
    required this.id,
    required this.rusunId,
    required this.rusunName,
    required this.buildingId,
    required this.buildingName,
    required this.floor,
    required this.code,
    required this.unitNumber,
    required this.unitStatus,
    required this.residentName,
    required this.mobilePhoneNumber,
    required this.emailAddress,
    required this.plnNumber,
    required this.pdamNumber,
    required this.plnMeterStatus,
    required this.pdamMeterStatus,
    required this.plnMeterStatusName,
    required this.pdamMeterStatusName,
    required this.firstMeterValue,
    required this.lastMeterValue,
    required this.meterPostDtime,
  });

  @Id(assignable: true)
  final int id;
  final int rusunId;
  final String rusunName;
  final int buildingId;
  final String buildingName;
  final int floor;
  final String code;
  final String unitNumber;
  final String unitStatus;
  final String? residentName;
  final String? mobilePhoneNumber;
  final String? emailAddress;
  final String plnNumber;
  final String pdamNumber;
  final int plnMeterStatus;
  final int pdamMeterStatus;
  final String plnMeterStatusName;
  final String pdamMeterStatusName;
  final double? firstMeterValue;
  final double? lastMeterValue;
  final DateTime? meterPostDtime;

  factory RusunUnit.fromJson(Map<String, dynamic> json) =>
      _$RusunUnitFromJson(json);

  Map<String, dynamic> toJson() => _$RusunUnitToJson(this);
}
