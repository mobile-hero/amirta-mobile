part of 'complaint_list_bloc.dart';

@immutable
abstract class ComplaintListState {}

class ComplaintListInitial extends ComplaintListState {}

class ComplaintListLoading extends ComplaintListState {}

class ComplaintListSuccess extends ComplaintListState {}

class ComplaintListError extends ComplaintListState {}
