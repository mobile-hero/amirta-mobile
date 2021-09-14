import 'package:amirta_mobile/data/account/dashboard.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dashboard_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class DashboardResponse {
  DashboardResponse({
    required this.responsecode,
    required this.responsemessage,
    required this.data,
  });

  final String responsecode;
  final String responsemessage;
  final Dashboard data;

  factory DashboardResponse.fromJson(Map<String, dynamic> json) =>
      _$DashboardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardResponseToJson(this);
}
