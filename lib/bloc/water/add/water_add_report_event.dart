part of 'water_add_report_bloc.dart';

@immutable
abstract class WaterAddReportEvent {}

class AddReport extends WaterAddReportEvent {
  final MeterDataWrite dataWrite;
  final bool meterCondition;

  AddReport(
    this.meterCondition,
    this.dataWrite,
  );
}

class AddReportOffline extends WaterAddReportEvent {
  final MeterDataWrite dataWrite;
  final bool meterCondition;

  AddReportOffline(
    this.meterCondition,
    this.dataWrite,
  );
}
