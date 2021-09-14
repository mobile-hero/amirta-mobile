import 'package:amirta_mobile/data/rusun/rusun_lite.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dashboard.g.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class Dashboard {
  Dashboard({
    required this.totalPanicButton,
    required this.totalComplaint,
    required this.totalUncollectedMeterPdam,
  });

  final int totalPanicButton;
  final int totalComplaint;
  final int totalUncollectedMeterPdam;

  factory Dashboard.fromJson(Map<String, dynamic> json) =>
      _$DashboardFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardToJson(this);

}