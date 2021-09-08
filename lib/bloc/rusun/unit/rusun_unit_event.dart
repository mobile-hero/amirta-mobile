part of 'rusun_unit_bloc.dart';

@immutable
abstract class RusunUnitEvent {}

class LoadUnit extends RusunUnitEvent {
  final int rusunId;
  final int buildingId;
  final int page;
  final int? floor;
  final String? code;

  LoadUnit(
    this.rusunId,
    this.buildingId,
    this.page,
    this.floor,
    this.code,
  );
}
