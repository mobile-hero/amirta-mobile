part of 'email_password_bloc.dart';

@immutable
abstract class EmailPasswordState {}

class EmailPasswordInitial extends EmailPasswordState {}

class EmailPasswordLoading extends EmailPasswordState {}

class EmailPasswordSuccess extends EmailPasswordState {}

class EmailPasswordError extends EmailPasswordState {
  final String message;

  EmailPasswordError(this.message);
}
