part of 'water_add_report_bloc.dart';

@immutable
abstract class WaterAddReportEvent {}

class AddReport extends WaterAddReportEvent {
  final MeterDataWrite dataWrite;

  AddReport(this.dataWrite);
}
