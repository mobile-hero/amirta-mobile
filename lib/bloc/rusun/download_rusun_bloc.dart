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

      // download and save blok
      final blokBox = store.box<RusunBlok>();
      blokBox.removeAll();

      // download and save unit
      final unitBox = store.box<RusunUnit>();
      unitBox.removeAll();

      final unitValueBox = store.box<RusunUnitValue>();
      if (unitValueBox.count(limit: 5000) >= 5000) {
        unitValueBox.removeAll();
      }
      final allValue = unitValueBox
          .query(
            RusunUnitValue_.month.equals(event.month) &
                RusunUnitValue_.year.equals(event.year),
          )
          .build()
          .find();
      print(allValue.map((e) => e.toJson()));

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

        for (final unit in unitResponse.data) {
          final unitValue = RusunUnitValue(
            unitId: unit.id,
            rusunId: unit.rusunId,
            buildingId: unit.buildingId,
            floor: unit.floor,
            code: unit.code,
            unitNumber: unit.unitNumber,
            unitStatus: unit.unitStatus,
            plnNumber: unit.plnNumber,
            pdamNumber: unit.pdamNumber,
            plnMeterStatus: unit.plnMeterStatus,
            pdamMeterStatus: unit.pdamMeterStatus,
            firstMeterValue: unit.firstMeterValue,
            lastMeterValue: unit.lastMeterValue,
            meterPostDtime: unit.meterPostDtime,
            month: event.month,
            year: event.year,
          );
          try {
            if (allValue.isNotEmpty) {
              final existing = allValue.firstWhere((e) => e.unitId == unit.id);
              unitValue.id = existing.id;
              print("Existing id found = ${existing.id}");
            }
          } catch (e) {}
          print(unitValue.toJson());
          unitValueBox.put(unitValue);
        }
      }

      store.close();
      yield DownloadRusunSuccess();
    } catch (e) {
      print(e);
      yield DownloadRusunError();
    }
  }
}
