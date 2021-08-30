part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginNow extends LoginEvent {
  final String nrk;
  final String password;
  LoginNow(this.nrk, this.password);
}