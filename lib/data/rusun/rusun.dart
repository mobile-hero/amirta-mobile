import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'rusun.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
@Entity()
class Rusun {
  Rusun({
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
  });

  @Id(assignable: true)
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
  
  factory Rusun.fromJson(Map<String, dynamic> json) => _$RusunFromJson(json);
  
  Map<String, dynamic> toJson() => _$RusunToJson(this);
}
