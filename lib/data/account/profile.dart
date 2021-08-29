import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Profile {
  Profile({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.address,
    required this.city,
    required this.district,
    required this.village,
    required this.latlng,
    required this.photo,
    required this.uprsName,
    required this.loginType,
    required this.sessid,
  });
  
  final int id;
  final String code;
  final String name;
  final String description;
  final String address;
  final String city;
  final String district;
  final String village;
  final String latlng;
  final String photo;
  final String uprsName;
  final int? loginType;
  final String? sessid;
  
  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
  
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
