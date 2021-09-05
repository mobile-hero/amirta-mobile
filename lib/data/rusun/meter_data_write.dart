import 'package:json_annotation/json_annotation.dart';

part 'meter_data_write.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MeterDataWrite {
  MeterDataWrite({
    required this.rusunId,
    required this.buildingId,
    required this.unitId,
    required this.month,
    required this.year,
    required this.meterType,
    required this.meterValue,
    required this.notes,
    required this.image,
  });

  final int rusunId;
  final int buildingId;
  final int unitId;
  final int month;
  final String year;
  final int meterType;
  final double meterValue;
  final String notes;
  final String image;

  factory MeterDataWrite.fromJson(Map<String, dynamic> json) =>
      _$MeterDataWriteFromJson(json);

  Map<String, dynamic> toJson() => _$MeterDataWriteToJson(this);
}