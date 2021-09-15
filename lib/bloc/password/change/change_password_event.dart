part of 'change_password_bloc.dart';

@immutable
abstract class ChangePasswordEvent {}

class ResetPassword extends ChangePasswordEvent {
  final String newPassword;
  final String confirmPassword;

  ResetPassword(this.newPassword, this.confirmPassword);
}

class ChangePassword extends ChangePasswordEvent {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePassword(this.currentPassword, this.newPassword, this.confirmPassword);
}
