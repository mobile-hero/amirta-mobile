part of 'upload_bloc.dart';

@immutable
abstract class UploadState {}

class UploadInitial extends UploadState {}

class UploadLoading extends UploadState {}

class UploadSuccess extends UploadState {
  final String url;

  UploadSuccess(this.url);
}

class UploadOffline extends UploadState {
  final String base64;

  UploadOffline(this.base64);
}

class UploadError extends UploadState {}
