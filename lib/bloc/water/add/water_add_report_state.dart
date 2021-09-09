part of 'water_add_report_bloc.dart';

@immutable
abstract class WaterAddReportState {}

class WaterAddReportInitial extends WaterAddReportState {}

class WaterAddReportLoading extends WaterAddReportState {}

class WaterAddReportSuccess extends WaterAddReportState {}

class WaterAddReportSuccessLocal extends WaterAddReportState {}

class WaterAddReportError extends WaterAddReportState {
  final String errorMessage;

  WaterAddReportError(this.errorMessage);
}
