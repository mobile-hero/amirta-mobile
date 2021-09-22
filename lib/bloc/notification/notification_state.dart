part of 'notification_bloc.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationSuccess extends NotificationState {}

class NotificationError extends NotificationState {}
