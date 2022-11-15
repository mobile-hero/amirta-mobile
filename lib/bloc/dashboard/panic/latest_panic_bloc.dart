import 'dart:async';

import 'package:amirta_mobile/data/pengaduan/pengaduan_export.dart';
import 'package:amirta_mobile/repository/pengaduan_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'latest_panic_event.dart';

part 'latest_panic_state.dart';

class LatestPanicBloc extends Bloc<LatestPanicEvent, LatestPanicState> {
  final PengaduanRepository pengaduanRepository;

  LatestPanicBloc(this.pengaduanRepository) : super(LatestPanicInitial());
  final limit = 20;

  @override
  Stream<LatestPanicState> mapEventToState(
    LatestPanicEvent event,
  ) async* {
    switch (event.runtimeType) {
      case LoadLatestPanic:
        yield* loadComplaint(event as LoadLatestPanic);
        break;
    }
  }

  Stream<LatestPanicState> loadComplaint(LoadLatestPanic event) async* {
    try {
      yield LatestPanicLoading();
      final response = await pengaduanRepository.getList(
        ComplaintType.panic,
        ComplaintStatus.newItem,
        1,
        limit,
      );
      if (response.length == 0) {
        yield LatestPanicSuccess(null);
      } else {
        yield LatestPanicSuccess(response.data.first);
      }
    } catch (e) {
      yield LatestPanicError();
    }
  }
}
