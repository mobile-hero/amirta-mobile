part of 'photo_profile_bloc.dart';

@immutable
abstract class PhotoProfileEvent {}

class UploadPhoto extends PhotoProfileEvent {
  final XFile file;

  UploadPhoto(this.file);
}
