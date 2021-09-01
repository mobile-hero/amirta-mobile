import 'package:amirta_mobile/data/pengaduan/pengaduan.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pengaduan_detail_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PengaduanDetailResponse {
  PengaduanDetailResponse({
    required this.responsecode,
    required this.responsemessage,
    required this.data,
  });

  final String responsecode;
  final String responsemessage;
  final Pengaduan data;

  factory PengaduanDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$PengaduanDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PengaduanDetailResponseToJson(this);
}
