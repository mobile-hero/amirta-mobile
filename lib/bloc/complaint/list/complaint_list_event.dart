part of 'complaint_list_bloc.dart';

@immutable
abstract class ComplaintListEvent {}

class LoadComplaint extends ComplaintListEvent {
  final int status;

  LoadComplaint(this.status);

  static final newItem = LoadComplaint(ComplaintStatus.newItem);
  static final inProcess = LoadComplaint(ComplaintStatus.inProcess);
  static final rejected = LoadComplaint(ComplaintStatus.rejected);
  static final completed = LoadComplaint(ComplaintStatus.completed);
}

class LoadMoreComplaint extends ComplaintListEvent {
  final int status;
  final int nextPageKey;

  LoadMoreComplaint(this.status, this.nextPageKey);
}
