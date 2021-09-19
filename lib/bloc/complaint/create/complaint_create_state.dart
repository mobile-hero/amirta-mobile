part of 'complaint_create_bloc.dart';

@immutable
abstract class ComplaintCreateState {}

class ComplaintCreateInitial extends ComplaintCreateState {}

class ComplaintCreateLoading extends ComplaintCreateState {}

class ComplaintCreateSuccess extends ComplaintCreateState {}

class ComplaintCreateError extends ComplaintCreateState {
  final String message;
  
  ComplaintCreateError(this.message);
}
