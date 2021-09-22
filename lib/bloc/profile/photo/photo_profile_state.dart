part of 'photo_profile_bloc.dart';

@immutable
abstract class PhotoProfileState {}

class PhotoProfileInitial extends PhotoProfileState {}

class PhotoProfileLoading extends PhotoProfileState {}

class PhotoProfileSuccess extends PhotoProfileState {
  final String url;

  PhotoProfileSuccess(this.url);
}

class PhotoProfileError extends PhotoProfileState {}
