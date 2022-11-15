import 'dart:async';

import 'package:amirta_mobile/data/rusun/rusun_export.dart';
import 'package:amirta_mobile/objectbox.g.dart';
import 'package:amirta_mobile/repository/repository.dart';
import 'package:amirta_mobile/utils/connectivity_result_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';

part 'water_sync_event.dart';

part 'water_sync_state.dart';

class WaterSyncBloc extends Bloc<WaterSyncEvent, WaterSyncState> {
  final RusunRepository rusunRepository;
  final UploadImageRepository imageRepository;
  final Connectivity connectivity;

  WaterSyncBloc(this.rusunRepository, this.imageRepository, this.connectivity)
      : super(const WaterSyncInitial(0));

  int total = 0;

  @override
  Stream<WaterSyncState> mapEventToState(
    WaterSyncEvent event,
  ) async* {
    if (event is LoadTotalUnsynced) {
      yield* _loadTotalUnsync(event);
    } else if (event is UploadSavedData) {
      yield* _uploadSavedData(event);
    }
  }

  Stream<WaterSyncState> _loadTotalUnsync(LoadTotalUnsynced event) async* {
    final store = await openStore();
    final dataBox = store.box<MeterDataWrite>();
    total = dataBox.count();
    store.close();
    yield WaterUnsyncLoaded(total);
  }

  Stream<WaterSyncState> _uploadSavedData(UploadSavedData event) async* {
    final result = await connectivity.checkConnectivity();
    if (!result.isConnected) {
      yield WaterSyncError('txt_no_internet_connection'.tr(), total);
      return;
    }

    final store = await openStore();
    try {
      yield WaterSyncLoading(total);

      // get data meter
      final dataBox = store.box<MeterDataWrite>();
      final existing = dataBox.getAll();

      /*// get meter status
      final statusBox = store.box<MeterStatusWrite>();
      final statusExisting = statusBox.getAll();*/

      for (int i = 0; i < existing.length; i++) {
        // upload image if base64 present
        final data = existing[i];
        if (data.photoBase64 != null) {
          final uploadResponse =
              await imageRepository.uploadImageFile(data.photoBase64!);
          data.image = uploadResponse.data.name;
          data.photoBase64 = null;
          dataBox.put(data);
        }

        /*MeterStatusWrite? status;
        try {
          status = statusExisting.firstWhere((e) => e.unitId == data.unitId);
        } catch (e) {}

        if (status != null) {
          final statusResponse =
              await rusunRepository.changeMeterStatus(status);
          statusBox.remove(status.id!);
        }*/
        final _ = await rusunRepository.addMeterData(data);
        dataBox.remove(data.id!);

        final unitBox = store.box<RusunUnitValue>();
        final result = unitBox
            .query(
              RusunUnitValue_.unitId.equals(data.unitId) &
                  RusunUnitValue_.month.equals(data.month) &
                  RusunUnitValue_.year.equals(int.parse(data.year)),
            )
            .build()
            .findFirst();

        if (result != null) {
          result.pdamMeterStatus = data.status;
          result.lastMeterValue = data.meterValue;
          result.meterPostDtime = DateTime.now();
          unitBox.put(result);
        }

        yield WaterSyncProgress(existing.length / (i + 1), total);
      }

      store.close();
      yield WaterSyncSuccess(--total);
    } catch (e) {
      store.close();
      yield WaterSyncError('txt_sync_failed'.tr(), total);
    }
  }
}
