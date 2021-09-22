import 'package:amirta_mobile/data/account/user_notification.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_notification_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserNotificationResponse {
  UserNotificationResponse({
    required this.responsecode,
    required this.responsemessage,
    required this.length,
    required this.data,
  });

  final String responsecode;
  final String responsemessage;
  final int length;
  final List<UserNotification> data;

  factory UserNotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$UserNotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserNotificationResponseToJson(this);
}
