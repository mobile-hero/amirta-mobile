import 'package:amirta_mobile/data/rusun/rusun_blok.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rusun_blok_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RusunBlokResponse {
  RusunBlokResponse({
    required this.responsecode,
    required this.responsemessage,
    required this.length,
    required this.data,
  });

  final String responsecode;
  final String responsemessage;
  final int length;
  final List<RusunBlok> data;

  factory RusunBlokResponse.fromJson(Map<String, dynamic> json) =>
      _$RusunBlokResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RusunBlokResponseToJson(this);
}
