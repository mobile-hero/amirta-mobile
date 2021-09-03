part of 'rusun_blok_bloc.dart';

@immutable
abstract class RusunBlokEvent {}

class LoadBlok extends RusunBlokEvent {
  final int rusunId;
  
  LoadBlok(this.rusunId);
}