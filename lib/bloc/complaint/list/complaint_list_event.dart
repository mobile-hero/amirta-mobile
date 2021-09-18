part of 'complaint_list_bloc.dart';

@immutable
abstract class ComplaintListEvent {}

class LoadComplaint extends ComplaintListEvent {
  final int status;

  LoadComplaint(this.status);
}

class LoadMoreComplaint extends ComplaintListEvent {
  final int status;
  final int nextPageKey;

  LoadMoreComplaint(this.status, this.nextPageKey);
}

class LoadPanic extends ComplaintListEvent {
  final int status;

  LoadPanic(this.status);
}

class LoadMorePanic extends ComplaintListEvent {
  final int status;
  final int nextPageKey;

  LoadMorePanic(this.status, this.nextPageKey);
}
