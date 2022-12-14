part of 'rusun_blok_bloc.dart';

@immutable
abstract class RusunBlokState {}

class RusunBlokInitial extends RusunBlokState {}

class RusunBlokLoading extends RusunBlokState {}

class RusunBlokSuccess extends RusunBlokState {
  final List<RusunBlok> result;

  RusunBlokSuccess(this.result);
}

class RusunBlokError extends RusunBlokState {}
