import 'dart:async';

import 'package:amirta_mobile/data/rusun/meter_data_write.dart';
import 'package:amirta_mobile/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'water_add_report_event.dart';

part 'water_add_report_state.dart';

class WaterAddReportBloc
    extends Bloc<WaterAddReportEvent, WaterAddReportState> {
  final RusunRepository rusunRepository;

  WaterAddReportBloc(this.rusunRepository) : super(WaterAddReportInitial());

  @override
  Stream<WaterAddReportState> mapEventToState(
    WaterAddReportEvent event,
  ) async* {
    if (event is AddReport) {
      yield* _addReport(event);
    }
  }

  Stream<WaterAddReportState> _addReport(AddReport event) async* {
    try {
      yield WaterAddReportLoading();
      final response = await rusunRepository.addMeterData(event.dataWrite);
      yield WaterAddReportSuccess();
    } catch (e) {
      yield WaterAddReportError();
    }
  }
}
