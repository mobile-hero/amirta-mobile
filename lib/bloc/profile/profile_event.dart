part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class LoadAccount extends ProfileEvent {}

class SaveAccount extends ProfileEvent {
  final String phone;
  final String email;

  SaveAccount(this.phone, this.email);
}
