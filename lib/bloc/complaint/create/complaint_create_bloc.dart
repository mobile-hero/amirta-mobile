import 'dart:async';
import 'dart:convert';

import 'package:amirta_mobile/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:mime/mime.dart';

part 'complaint_create_event.dart';

part 'complaint_create_state.dart';

class ComplaintCreateBloc
    extends Bloc<ComplaintCreateEvent, ComplaintCreateState> {
  final PengaduanRepository pengaduanRepository;
  final UploadImageRepository uploadImageRepository;

  ComplaintCreateBloc(this.pengaduanRepository, this.uploadImageRepository)
      : super(ComplaintCreateInitial());

  @override
  Stream<ComplaintCreateState> mapEventToState(
    ComplaintCreateEvent event,
  ) async* {
    if (event is CreateComplaint) {
      yield* createComplaint(event);
    } else if (event is ContinueCreateComplaint) {
      yield* continueCreate(event);
    } else if (event is AcceptPanic) {
      yield* acceptPanic(event);
    }
  }

  Stream<ComplaintCreateState> createComplaint(CreateComplaint event) async* {
    yield ComplaintCreateLoading();
    if (event.images != null) {
      final List<String> uploaded = [];
      for (final image in event.images!) {
        try {
          final xfile = image;
          final compressed = await FlutterImageCompress.compressWithFile(
            xfile.path,
            quality: 95,
            keepExif: true,
          );

          final base64 = base64Encode(compressed!);
          final mimeType = lookupMimeType(xfile.path);
          final uriData = "data:$mimeType;base64," + base64;
          final response = await uploadImageRepository.uploadImageFile(uriData);
          uploaded.add(response.data.name);
        } catch (e) {}
      }

      if (uploaded.isNotEmpty) {
        add(ContinueCreateComplaint(
          pengaduanId: event.pengaduanId,
          status: event.status,
          notes: event.notes,
          images: uploaded,
        ));
      } else {
        yield ComplaintCreateError("Gagal mengupload gambar");
      }
    } else {
      add(ContinueCreateComplaint(
        pengaduanId: event.pengaduanId,
        status: event.status,
        notes: event.notes,
        images: null,
      ));
    }
  }

  Stream<ComplaintCreateState> continueCreate(
      ContinueCreateComplaint event) async* {
    try {
      yield ComplaintCreateLoading();
      final response = await pengaduanRepository.postExamination(
          event.pengaduanId, event.status, event.notes, event.images);
      yield ComplaintCreateSuccess();
    } on DioError catch (e) {
      yield ComplaintCreateError(e.response!.data);
    }
  }

  Stream<ComplaintCreateState> acceptPanic(AcceptPanic event) async* {
    try {
      yield ComplaintCreateLoading();
      final response = await pengaduanRepository.acceptRejectPanic(
          event.pengaduanId, event.status);
      yield ComplaintCreateSuccess();
    } on DioError catch (e) {
      yield ComplaintCreateError(e.response!.data);
    }
  }
}
