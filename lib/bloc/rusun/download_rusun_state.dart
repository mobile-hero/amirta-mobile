part of 'download_rusun_bloc.dart';

@immutable
abstract class DownloadRusunState {}

class DownloadRusunInitial extends DownloadRusunState {}

class DownloadRusunLoading extends DownloadRusunState {}

class DownloadRusunSuccess extends DownloadRusunState {}

class DownloadRusunError extends DownloadRusunState {}
