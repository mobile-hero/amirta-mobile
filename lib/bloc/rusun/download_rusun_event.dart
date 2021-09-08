part of 'download_rusun_bloc.dart';

@immutable
abstract class DownloadRusunEvent {}

class DownloadWaterData extends DownloadRusunEvent {
  final int month;
  final int year;

  DownloadWaterData(this.month, this.year);
}
