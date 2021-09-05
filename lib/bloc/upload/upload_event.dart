part of 'upload_bloc.dart';

@immutable
abstract class UploadEvent {}

class UploadImage extends UploadEvent {
  final XFile file;

  UploadImage(this.file);
}
