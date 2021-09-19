part of 'complaint_detail_bloc.dart';

@immutable
abstract class ComplaintDetailEvent {}

class LoadComplaint extends ComplaintDetailEvent {
  final int complaintId;

  LoadComplaint(this.complaintId);
}
