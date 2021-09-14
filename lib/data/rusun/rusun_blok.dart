import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'rusun_blok.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
@Entity()
class RusunBlok {
  RusunBlok({
    required this.id,
    required this.code,
    required this.name,
    required this.buildingType,
  });

  @Id(assignable: true)
  final int id;
  final String code;
  final String name;
  final String buildingType;
  
  @Index()
  int? rusunId;
  
  factory RusunBlok.fromJson(Map<String, dynamic> json) => _$RusunBlokFromJson(json);
  
  Map<String, dynamic> toJson() => _$RusunBlokToJson(this);
  
  String get displayName => "$buildingType $name";
}
