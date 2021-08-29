import 'package:json_annotation/json_annotation.dart';

part 'rusun_lite.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RusunLite {
  RusunLite({
    required this.id,
    required this.name,
  });
  
  final int id;
  final String name;
  
  factory RusunLite.fromJson(Map<String, dynamic> json) => _$RusunLiteFromJson(json);
  
  Map<String, dynamic> toJson() => _$RusunLiteToJson(this);
}
