import 'dart:async';

import 'package:amirta_mobile/data/rusun/rusun_export.dart';
import 'package:amirta_mobile/objectbox.g.dart';
import 'package:amirta_mobile/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'download_rusun_event.dart';

part 'download_rusun_state.dart';

class DownloadRusunBloc extends Bloc<DownloadRusunEvent, DownloadRusunState> {
  final RusunRepository rusunRepository;

  DownloadRusunBloc(this.rusunRepository) : super(DownloadRusunInitial());

  @override
  Stream<DownloadRusunState> mapEventToState(
    DownloadRusunEvent event,
  ) async* {
    if (event is DownloadWaterData) {
      yield* downloadWaterData(event);
    }
  }

  Stream<DownloadRusunState> downloadWaterData(
    DownloadWaterData event,
  ) async* {
    try {
      yield DownloadRusunLoading();
      final store = await openStore();
      
      // download and save rusun
      final rusunResponse = await rusunRepository.getRusunawa();
      final rusunBox = store.box<Rusun>();
      rusunBox.removeAll();
      rusunBox.putMany(rusunResponse.data);
      
      print(rusunBox.getAll());

      // download and save blok
      final blokBox = store.box<RusunBlok>();
      blokBox.removeAll();

      // download and save unit
      final unitBox = store.box<RusunUnit>();
      unitBox.removeAll();
      
      for (final rusun in rusunResponse.data) {
        final blokResponse = await rusunRepository.getBlok(rusun.id);
        blokBox.putMany(blokResponse.data);

        final unitResponse = await rusunRepository.getUnit(
          rusunId: rusun.id,
          page: 1,
          limit: 0,
          meterType: 1,
          month: event.month,
          year: event.year,
          isReported: false,
        );
        unitBox.putMany(unitResponse.data);
      }

      store.close();
      yield DownloadRusunSuccess();
    } catch (e) {
      yield DownloadRusunError();
    }
  }
}
