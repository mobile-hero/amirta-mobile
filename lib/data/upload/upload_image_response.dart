import 'package:amirta_mobile/data/upload/upload_image_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_image_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UploadImageResponse {
  UploadImageResponse({
    required this.responsecode,
    required this.responsemessage,
    required this.data,
  });

  final String responsecode;
  final String responsemessage;
  final UploadImageData data;

  factory UploadImageResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadImageResponseToJson(this);
}
