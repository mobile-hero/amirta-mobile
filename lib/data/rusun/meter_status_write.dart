import 'package:json_annotation/json_annotation.dart';

part 'meter_status_write.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MeterStatusWrite {
  MeterStatusWrite({
    required this.unitId,
    required this.meterType,
    required this.status,
  });

  final int unitId;
  final int meterType;
  final int status;

  factory MeterStatusWrite.fromJson(Map<String, dynamic> json) =>
      _$MeterStatusWriteFromJson(json);

  Map<String, dynamic> toJson() => _$MeterStatusWriteToJson(this);
}
