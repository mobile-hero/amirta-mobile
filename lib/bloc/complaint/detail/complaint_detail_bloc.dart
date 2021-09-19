import 'dart:async';

import 'package:amirta_mobile/data/pengaduan/pengaduan.dart';
import 'package:amirta_mobile/repository/pengaduan_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'complaint_detail_event.dart';

part 'complaint_detail_state.dart';

class ComplaintDetailBloc
    extends Bloc<ComplaintDetailEvent, ComplaintDetailState> {
  final PengaduanRepository pengaduanRepository;

  ComplaintDetailBloc(this.pengaduanRepository)
      : super(ComplaintDetailInitial());

  @override
  Stream<ComplaintDetailState> mapEventToState(
    ComplaintDetailEvent event,
  ) async* {
    if (event is LoadComplaint) {
      yield* loadComplaint(event);
    }
  }

  Stream<ComplaintDetailState> loadComplaint(LoadComplaint event) async* {
    try {
      yield ComplaintDetailLoading();
      final response =
          await pengaduanRepository.detailExamination(event.complaintId);
      yield ComplaintDetailSuccess(response.data);
    } catch (e) {
      yield ComplaintDetailError();
    }
  }
}
