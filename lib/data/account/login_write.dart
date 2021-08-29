import 'package:json_annotation/json_annotation.dart';

part 'login_write.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginWrite {
  LoginWrite({
    required this.loginType,
    required this.userid,
    required this.passwd,
    required this.emailAddress,
    required this.loginId,
    required this.name,
  });
  
  final int loginType;
  final String userid;
  final String passwd;
  final String emailAddress;
  final String loginId;
  final String name;

  factory LoginWrite.fromJson(Map<String, dynamic> json) => _$LoginWriteFromJson(json);

  Map<String, dynamic> toJson() => _$LoginWriteToJson(this);
}
