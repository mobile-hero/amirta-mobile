import 'package:json_annotation/json_annotation.dart';

part 'simple_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SimpleResponse {
  final String responsecode;
  final String responsemessage;

  SimpleResponse({
    required this.responsecode,
    required this.responsemessage,
  });

  factory SimpleResponse.fromJson(Map<String, dynamic> json) => _$SimpleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleResponseToJson(this);
}
