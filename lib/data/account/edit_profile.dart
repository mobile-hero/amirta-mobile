import 'package:json_annotation/json_annotation.dart';

part 'edit_profile.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EditProfile {
  EditProfile({
    required this.mobilePhoneNumber,
    required this.emailAddress,
  });
  
  final String mobilePhoneNumber;
  final String emailAddress;
  
  factory EditProfile.fromJson(Map<String, dynamic> json) => _$EditProfileFromJson(json);
  
  Map<String, dynamic> toJson() => _$EditProfileToJson(this);
}
