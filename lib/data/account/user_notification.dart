import 'package:amirta_mobile/my_material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_notification.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserNotification {
  UserNotification({
    required this.id,
    required this.pid,
    required this.refId,
    required this.typ,
    required this.images,
    required this.message,
    required this.payload,
    required this.sendTime,
    required this.title,
    required this.notificationType,
  });
  
  final int id;
  final int pid;
  final int refId;
  final int typ;
  final String images;
  final String message;
  final dynamic payload;
  final String sendTime;
  final String title;
  final String notificationType;

  factory UserNotification.fromJson(Map<String, dynamic> json) => _$UserNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$UserNotificationToJson(this);
  
  String get sendTimeFormatted {
    final DateFormat format = DateFormat('dd/MM/y HH:mm', 'id');
    return format.format(DateTime.parse(sendTime));
  }
}
