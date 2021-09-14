import 'dart:async';

import 'package:amirta_mobile/data/rusun/rusun_export.dart';
import 'package:amirta_mobile/objectbox.g.dart';
import 'package:amirta_mobile/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';

part 'rusun_unit_event.dart';

part 'rusun_unit_state.dart';

class RusunUnitBloc extends Bloc<RusunUnitEvent, RusunUnitState> {
  final RusunRepository rusunRepository;
  final int? rusunId;
  final int? buildingId;
  final int? floor;
  final String? code;
  final int month;
  final int year;

  RusunUnitBloc(
    this.rusunRepository,
    this.rusunId,
    this.buildingId,
    this.floor,
    this.code,
    this.month,
    this.year,
  ) : super(RusunUnitInitial()) {
    pagingController.addPageRequestListener((pageKey) {
      if (pageKey == 0) {
        add(LoadUnit(
          rusunId ?? lastRusunId,
          buildingId ?? lastBuildingId,
          1,
          floor,
          code,
        ));
      } else {
        add(LoadUnit(
          rusunId ?? lastRusunId,
          buildingId ?? lastBuildingId,
          pageKey ~/ limit,
          floor,
          code,
        ));
      }
    });
  }

  PagingController<int, RusunUnit> pagingController =
      PagingController(firstPageKey: 0);

  final limit = 20;
  bool local = false;
  List<RusunUnitValue> values = [];

  int lastRusunId = 0;
  int lastBuildingId = 0;

  @override
  Stream<RusunUnitState> mapEventToState(
    RusunUnitEvent event,
  ) async* {
    if (event is LoadUnit) {
      yield* getUnit(event);
    }
  }

  Stream<RusunUnitState> getUnit(LoadUnit event) async* {
    lastRusunId = event.rusunId;
    lastBuildingId = event.buildingId;
    try {
      final store = await openStore();
      yield RusunUnitLoading();

      // get existing unit value
      final box = store.box<RusunUnitValue>();
      Condition<RusunUnitValue> queryCondition =
          RusunUnitValue_.rusunId.equals(event.rusunId) &
              RusunUnitValue_.buildingId.equals(event.buildingId) &
              RusunUnitValue_.month.equals(month) &
              RusunUnitValue_.year.equals(year);
      if (event.floor != null && event.floor != -1) {
        queryCondition =
            queryCondition.and(RusunUnitValue_.floor.equals(event.floor!));
      }
      if (event.code != null && event.code!.isNotEmpty) {
        queryCondition =
            queryCondition.and(RusunUnitValue_.unitNumber.equals(event.code!));
      }
      values = box.query(queryCondition).build().find();
      print(values);
      if (values.isNotEmpty) {
        // get existing unit value
        local = true;
        // get rusun unit value
        final box = store.box<RusunUnit>();
        Condition<RusunUnit> queryCondition =
            RusunUnit_.rusunId.equals(event.rusunId) &
                RusunUnit_.buildingId.equals(event.buildingId);
        if (event.floor != null && event.floor != -1) {
          queryCondition =
              queryCondition.and(RusunUnit_.floor.equals(event.floor!));
        }
        if (event.code != null && event.code!.isNotEmpty) {
          queryCondition =
              queryCondition.and(RusunUnit_.unitNumber.equals(event.code!));
        }
        final result = box.query(queryCondition).build().find();
        print(result);
        pagingController.appendLastPage(result);
        store.close();

        yield RusunUnitSuccess(result);
        return;
      }
      store.close();

      // online unit fallback
      final response = await rusunRepository.getUnit(
        rusunId: event.rusunId,
        buildingId: event.buildingId,
        floor: event.floor,
        page: event.page,
        meterType: 1,
        limit: limit,
        month: month,
        year: year
      );
      if (response.length < limit) {
        pagingController.appendLastPage(response.data);
      } else {
        pagingController.appendPage(
            response.data, pagingController.nextPageKey! + response.length);
      }
      yield RusunUnitSuccess(response.data);
    } catch (e) {
      yield RusunUnitError();
    }
  }
}
