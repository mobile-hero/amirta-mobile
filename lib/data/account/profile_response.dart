import 'package:amirta_mobile/data/account/profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProfileResponse {
  ProfileResponse({
    required this.responsecode,
    required this.responsemessage,
    required this.data,
  });
  
  final String responsecode;
  final String responsemessage;
  final Profile data;
  
  factory ProfileResponse.fromJson(Map<String, dynamic> json) => _$ProfileResponseFromJson(json);
  
  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}
