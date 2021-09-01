import 'package:amirta_mobile/data/pengaduan/pengaduan.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pengaduan_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PengaduanResponse {
  PengaduanResponse({
    required this.responsecode,
    required this.responsemessage,
    required this.length,
    required this.data,
  });

  final String responsecode;
  final String responsemessage;
  final int length;
  final List<Pengaduan> data;

  factory PengaduanResponse.fromJson(Map<String, dynamic> json) =>
      _$PengaduanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PengaduanResponseToJson(this);
}
