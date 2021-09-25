part of 'latest_panic_bloc.dart';

@immutable
abstract class LatestPanicState {}

class LatestPanicInitial extends LatestPanicState {}

class LatestPanicLoading extends LatestPanicState {}

class LatestPanicSuccess extends LatestPanicState {
  final Pengaduan? pengaduan;
  LatestPanicSuccess(this.pengaduan);
}

class LatestPanicError extends LatestPanicState {}
