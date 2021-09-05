import 'package:json_annotation/json_annotation.dart';

part 'upload_image_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UploadImageData {
  UploadImageData({
    required this.name,
  });

  final String name;

  factory UploadImageData.fromJson(Map<String, dynamic> json) =>
      _$UploadImageDataFromJson(json);

  Map<String, dynamic> toJson() => _$UploadImageDataToJson(this);
}
