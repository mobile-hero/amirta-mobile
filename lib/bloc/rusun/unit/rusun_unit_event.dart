part of 'rusun_unit_bloc.dart';

@immutable
abstract class RusunUnitEvent {}

class LoadUnit extends RusunUnitEvent {
  final int rusunId;
  final int buildingId;
  final int page;
  final int? floor;
  
  LoadUnit(this.rusunId, this.buildingId, this.page, this.floor);
}