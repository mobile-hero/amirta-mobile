part of 'rusun_bloc.dart';

@immutable
abstract class RusunState {}

class RusunInitial extends RusunState {}

class RusunLoading extends RusunState {}

class RusunSuccess extends RusunState {
  final RusunResponse result;

  RusunSuccess(this.result);
}

class RusunError extends RusunState {}
