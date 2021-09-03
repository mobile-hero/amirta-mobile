part of 'rusun_unit_bloc.dart';

@immutable
abstract class RusunUnitState {}

class RusunUnitInitial extends RusunUnitState {}

class RusunUnitLoading extends RusunUnitState {}

class RusunUnitSuccess extends RusunUnitState {
  final RusunUnitResponse result;

  RusunUnitSuccess(this.result);
}

class RusunUnitError extends RusunUnitState {}
