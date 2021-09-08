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
  final int rusunId;
  final int buildingId;
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
        add(LoadUnit(rusunId, buildingId, 1, floor, code));
      } else {
        add(LoadUnit(rusunId, buildingId, pageKey ~/ limit, floor, code));
      }
    });
    pagingController.refresh();
  }

  PagingController<int, RusunUnit> pagingController =
      PagingController(firstPageKey: 0);

  final limit = 20;
  bool local = false;
  List<RusunUnitValue> values = [];

  @override
  Stream<RusunUnitState> mapEventToState(
    RusunUnitEvent event,
  ) async* {
    if (event is LoadUnit) {
      yield* getUnit(event);
    }
  }

  Stream<RusunUnitState> getUnit(LoadUnit event) async* {
    try {
      yield RusunUnitLoading();
      final store = await openStore();

      // get rusun unit value
      final box = store.box<RusunUnit>();
      Condition<RusunUnit> queryCondition =
          RusunUnit_.rusunId.equals(event.rusunId) &
              RusunUnit_.buildingId.equals(event.buildingId);
      if (event.floor != null) {
        queryCondition =
            queryCondition.and(RusunUnit_.floor.equals(event.floor!));
      }
      final result = box.query(queryCondition).build().find();
      print(result);
      if (result.isNotEmpty) {
        // get existing unit value
        local = true;
        final box = store.box<RusunUnitValue>();
        Condition<RusunUnitValue> queryCondition =
            RusunUnitValue_.rusunId.equals(event.rusunId) &
                RusunUnitValue_.buildingId.equals(buildingId) &
                RusunUnitValue_.month.equals(month) &
                RusunUnitValue_.year.equals(year);
        if (event.floor != null) {
          queryCondition =
              queryCondition.and(RusunUnitValue_.floor.equals(event.floor!));
        }
        if (event.code != null) {
          queryCondition =
              queryCondition.and(RusunUnitValue_.code.equals(event.code!));
        }
        values = box.query(queryCondition).build().find();

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
        limit: limit,
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
