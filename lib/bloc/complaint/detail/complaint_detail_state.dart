part of 'complaint_detail_bloc.dart';

@immutable
abstract class ComplaintDetailState {}

class ComplaintDetailInitial extends ComplaintDetailState {}

class ComplaintDetailLoading extends ComplaintDetailState {}

class ComplaintDetailSuccess extends ComplaintDetailState {
  final Pengaduan pengaduan;

  ComplaintDetailSuccess(this.pengaduan);
}

class ComplaintDetailError extends ComplaintDetailState {}
