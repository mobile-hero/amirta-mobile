import 'package:amirta_mobile/data/rusun/rusun_unit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rusun_unit_detail_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RusunUnitDetailResponse {
  RusunUnitDetailResponse({
    required this.responsecode,
    required this.responsemessage,
    required this.data,
  });

  final String responsecode;
  final String responsemessage;
  final RusunUnit data;

  factory RusunUnitDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$RusunUnitDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RusunUnitDetailResponseToJson(this);
}
