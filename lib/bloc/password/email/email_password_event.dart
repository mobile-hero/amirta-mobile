part of 'email_password_bloc.dart';

@immutable
abstract class EmailPasswordEvent {}

class SendResetEmail extends EmailPasswordEvent {
  final String email;

  SendResetEmail(this.email);
}
