import 'dart:async';
import 'dart:convert';

import 'package:amirta_mobile/repository/upload_image_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:meta/meta.dart';
import 'package:mime/mime.dart';

part 'upload_event.dart';

part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final UploadImageRepository uploadImageRepository;

  UploadBloc(this.uploadImageRepository) : super(UploadInitial());

  @override
  Stream<UploadState> mapEventToState(
    UploadEvent event,
  ) async* {
    if (event is UploadImage) {
      yield* uploadImage(event);
    }
  }

  Stream<UploadState> uploadImage(UploadImage event) async* {
    try {
      yield UploadLoading();
      // compressed image
      final xfile = event.file;
      final compressed = await FlutterImageCompress.compressWithFile(
        xfile.path,
        quality: 95,
        keepExif: true,
      );

      final base64 = base64Encode(compressed!);
      final mimeType = lookupMimeType(xfile.path);
      final uriData = "data:$mimeType;base64," + base64;
      final response = await uploadImageRepository.uploadImageFile(uriData);
      yield UploadSuccess(response.data.name);
    } catch (e) {
      print(e);
      yield UploadError();
    }
  }
}
