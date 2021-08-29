import 'package:amirta_mobile/data/reference/rusun.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rusun_reponse.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RusunResponse {
  RusunResponse({
    required this.responsecode,
    required this.responsemessage,
    required this.length,
    required this.data,
  });
  
  final String responsecode;
  final String responsemessage;
  final int length;
  final List<Rusun> data;
  
  factory RusunResponse.fromJson(Map<String, dynamic> json) => _$RusunFromJson(json);
  
  Map<String, dynamic> toJson() => _$RusunToJson(this);
}
