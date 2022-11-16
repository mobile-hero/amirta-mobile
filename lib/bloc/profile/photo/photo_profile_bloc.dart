import 'dart:async';
import 'dart:convert';

import 'package:amirta_mobile/bloc/app_provider.dart';
import 'package:amirta_mobile/data/account/profile.dart';
import 'package:amirta_mobile/repository/repository.dart';
import 'package:amirta_mobile/utils/image_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:meta/meta.dart';
import 'package:mime/mime.dart';

part 'photo_profile_event.dart';

part 'photo_profile_state.dart';

class PhotoProfileBloc extends Bloc<PhotoProfileEvent, PhotoProfileState> {
  final UploadImageRepository uploadImageRepository;
  final AppProvider appProvider;

  PhotoProfileBloc(this.uploadImageRepository, this.appProvider)
      : super(PhotoProfileInitial());

  @override
  Stream<PhotoProfileState> mapEventToState(
    PhotoProfileEvent event,
  ) async* {
    if (event is UploadPhoto) {
      try {
        yield PhotoProfileLoading();
        final xfile = event.file;
        final compressed = await FlutterImageCompress.compressWithFile(
          xfile.path,
          quality: 95,
          keepExif: true,
        );

        final base64 = base64Encode(compressed!);
        final mimeType = lookupMimeType(xfile.path);
        final uriData = 'data:$mimeType;base64,' + base64;
        final response =
            await uploadImageRepository.uploadPhotoProfile(uriData);
        Profile user = appProvider.user!;
        user = user.copyWith(photo: response.data.photo);
        appProvider.setUser(user);
        yield PhotoProfileSuccess(response.data.photo!.photoProfileUrl);
      } catch (e) {
        yield PhotoProfileError();
      }
    }
  }
}
