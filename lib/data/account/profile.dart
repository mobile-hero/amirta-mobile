import 'package:amirta_mobile/data/reference/rusun_lite.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Profile {
  Profile({
    required this.pid,
    required this.userId,
    required this.isActive,
    required this.name,
    required this.mobilePhoneNumber,
    required this.emailAddress,
    required this.photo,
    required this.rusunList,
    required this.loginType,
    required this.sessid,
  });

  final int pid;
  final String userId;
  final bool isActive;
  final String name;
  final String mobilePhoneNumber;
  final String emailAddress;
  final String photo;
  final List<RusunLite> rusunList;
  final int? loginType;
  final String? sessid;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  Profile copyWith({
    int? pid,
    String? userId,
    String? name,
    String? mobilePhoneNumber,
    String? emailAddress,
    String? photo,
    bool? isActive,
    List<RusunLite>? rusunList,
    int? loginType,
    String? sessid,
  }) =>
      Profile(
        pid: pid ?? this.pid,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        mobilePhoneNumber: mobilePhoneNumber ?? this.mobilePhoneNumber,
        emailAddress: emailAddress ?? this.emailAddress,
        photo: photo ?? this.photo,
        isActive: isActive ?? this.isActive,
        loginType: loginType ?? this.loginType,
        sessid: sessid ?? this.sessid,
        rusunList: rusunList ?? this.rusunList,
      );
}
