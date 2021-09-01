import 'package:amirta_mobile/data/rusun/rusun_unit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rusun_unit_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RusunUnitResponse {
  RusunUnitResponse({
    required this.responsecode,
    required this.responsemessage,
    required this.length,
    required this.data,
  });

  final String responsecode;
  final String responsemessage;
  final int length;
  final List<RusunUnit> data;

  factory RusunUnitResponse.fromJson(Map<String, dynamic> json) =>
      _$RusunUnitResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RusunUnitResponseToJson(this);
}
