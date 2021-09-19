part of 'complaint_create_bloc.dart';

@immutable
abstract class ComplaintCreateEvent {}

class CreateComplaint extends ComplaintCreateEvent {
  final int pengaduanId;
  final int status;
  final String? notes;
  final List<XFile>? images;

  CreateComplaint({
    required this.pengaduanId,
    required this.status,
    this.notes,
    this.images,
  });
}

class ContinueCreateComplaint extends ComplaintCreateEvent {
  final int pengaduanId;
  final int status;
  final String? notes;
  final List<String>? images;

  ContinueCreateComplaint({
    required this.pengaduanId,
    required this.status,
    required this.notes,
    required this.images,
  });
}
