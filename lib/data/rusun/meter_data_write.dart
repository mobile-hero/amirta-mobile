import 'package:amirta_mobile/objectbox.g.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'meter_data_write.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
@Entity()
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
    required this.statusNotes,
    required this.status,
    required this.image,
  });

  @Id()
  int? id;
  @Index()
  final int rusunId;
  @Index()
  final int buildingId;
  @Index()
  final int unitId;
  final int month;
  final String year;
  final int meterType;
  final double? meterValue;
  final String? notes;
  final String? statusNotes;
  final int status;
  String? image;
  
  @JsonKey(ignore: true)
  String? photoBase64;

  factory MeterDataWrite.fromJson(Map<String, dynamic> json) =>
      _$MeterDataWriteFromJson(json);

  Map<String, dynamic> toJson() => _$MeterDataWriteToJson(this);
}
