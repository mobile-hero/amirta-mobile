import 'package:json_annotation/json_annotation.dart';

part 'pengaduan.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Pengaduan {
  Pengaduan({
    required this.id,
    required this.receivedDtime,
    required this.complaintNumber,
    required this.complaintCategoryId,
    required this.complaintCategoryName,
    required this.title,
    required this.content,
    required this.fname,
    required this.fdoc,
    required this.latlng,
    required this.statusName,
    required this.complainantName,
    required this.complainantPhoto,
    required this.rusunId,
    required this.rusunName,
    required this.buildingName,
    required this.floor,
    required this.unitNumber,
    required this.operatorId,
    required this.operatorNotes,
    required this.operatorName,
    required this.operatorAcceptedDtime,
  });

  final int id;
  final DateTime receivedDtime;
  final String complaintNumber;
  final int complaintCategoryId;
  final String complaintCategoryName;
  final String title;
  final String content;
  final String fname;
  final String? fdoc;
  final String latlng;
  final String statusName;
  final String complainantName;
  final String complainantPhoto;
  final int rusunId;
  final String rusunName;
  final String buildingName;
  final int floor;
  final String unitNumber;
  final int operatorId;
  final String? operatorNotes;
  final String? operatorName;
  final String? operatorAcceptedDtime;
  
  factory Pengaduan.fromJson(Map<String, dynamic> json) => _$PengaduanFromJson(json);
  
  Map<String, dynamic> toJson() => _$PengaduanToJson(this);
}
