import 'dart:async';

import 'package:amirta_mobile/data/rusun/rusun_export.dart';
import 'package:amirta_mobile/objectbox.g.dart';
import 'package:amirta_mobile/repository/repository.dart';
import 'package:amirta_mobile/utils/connectivity_result_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'water_add_report_event.dart';

part 'water_add_report_state.dart';

class WaterAddReportBloc
    extends Bloc<WaterAddReportEvent, WaterAddReportState> {
  final RusunRepository rusunRepository;
  final Connectivity connectivity;

  WaterAddReportBloc(this.rusunRepository, this.connectivity)
      : super(WaterAddReportInitial());

  @override
  Stream<WaterAddReportState> mapEventToState(
    WaterAddReportEvent event,
  ) async* {
    if (event is AddReport) {
      yield* _addReport(event);
    } else if (event is AddReportOffline) {
      yield* _addReportOffline(event);
    }
  }

  Stream<WaterAddReportState> _addReport(AddReport event) async* {
    final store = await openStore();
    try {
      yield WaterAddReportLoading();

      // get data meter
      final dataBox = store.box<MeterDataWrite>();
      final dataWrite = event.dataWrite;
      final existing = dataBox
          .query(MeterDataWrite_.unitId.equals(dataWrite.unitId))
          .build()
          .findFirst();
      dataWrite.id = existing?.id;
      final dataId = dataBox.put(dataWrite);

      // get meter status
      final statusBox = store.box<MeterStatusWrite>();
      final statusWrite = MeterStatusWrite(
        unitId: dataWrite.unitId,
        meterType: dataWrite.meterType,
        status: event.meterCondition ? 0 : 1,
      );
      final statusExisting = statusBox
          .query(MeterStatusWrite_.unitId.equals(dataWrite.unitId))
          .build()
          .findFirst();
      statusWrite.id = statusExisting?.id;
      final statusId = statusBox.put(statusWrite);

      final connResult = await connectivity.checkConnectivity();
      if (connResult.isConnected) {
        final statusResponse =
            await rusunRepository.changeMeterStatus(statusWrite);
        final response = await rusunRepository.addMeterData(dataWrite);

        dataBox.remove(dataId);
        statusBox.remove(statusId);

        final unitBox = store.box<RusunUnitValue>();
        final result = unitBox
            .query(
              RusunUnitValue_.unitId.equals(event.dataWrite.unitId) &
                  RusunUnitValue_.month.equals(event.dataWrite.month) &
                  RusunUnitValue_.year.equals(int.parse(event.dataWrite.year)),
            )
            .build()
            .findFirst();

        if (result != null) {
          result.pdamMeterStatus = statusWrite.status;
          result.lastMeterValue = event.dataWrite.meterValue;
          result.meterPostDtime = DateTime.now();
          unitBox.put(result);
        }

        if (statusResponse.requestSuccess && response.requestSuccess) {
          yield WaterAddReportSuccess();
        } else {
          yield WaterAddReportError(response.responsemessage);
        }
      } else {
        yield WaterAddReportSuccessLocal();
      }
      store.close();
    } catch (e) {
      store.close();
      yield WaterAddReportError(e.toString());
    }
  }

  Stream<WaterAddReportState> _addReportOffline(AddReportOffline event) async* {
    final store = await openStore();
    try {
      yield WaterAddReportLoading();

      // get data meter
      final dataBox = store.box<MeterDataWrite>();
      final dataWrite = event.dataWrite;
      final existing = dataBox
          .query(MeterDataWrite_.unitId.equals(dataWrite.unitId))
          .build()
          .findFirst();
      dataWrite.id = existing?.id;
      final dataId = dataBox.put(dataWrite);

      // get meter status
      final statusBox = store.box<MeterStatusWrite>();
      final statusWrite = MeterStatusWrite(
        unitId: dataWrite.unitId,
        meterType: dataWrite.meterType,
        status: event.meterCondition ? 0 : 1,
      );
      final statusExisting = statusBox
          .query(MeterStatusWrite_.unitId.equals(dataWrite.unitId))
          .build()
          .findFirst();
      statusWrite.id = statusExisting?.id;
      final statusId = statusBox.put(statusWrite);

      final unitBox = store.box<RusunUnitValue>();
      final result = unitBox
          .query(
            RusunUnitValue_.unitId.equals(event.dataWrite.unitId) &
                RusunUnitValue_.month.equals(event.dataWrite.month) &
                RusunUnitValue_.year.equals(int.parse(event.dataWrite.year)),
          )
          .build()
          .findFirst();

      if (result != null) {
        result.pdamMeterStatus = statusWrite.status;
        result.lastMeterValue = event.dataWrite.meterValue;
        result.meterPostDtime = DateTime.now();
        unitBox.put(result);
      }

      store.close();
      yield WaterAddReportSuccessLocal();
    } catch (e) {
      store.close();
      yield WaterAddReportError(e.toString());
    }
  }
}
