import 'dart:async';

import 'package:amirta_mobile/data/rusun/rusun_export.dart';
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
  final dynamic floor;

  RusunUnitBloc(this.rusunRepository, this.rusunId, this.buildingId, this.floor)
      : super(RusunUnitInitial()) {
    pagingController.addPageRequestListener((pageKey) {
      if (pageKey == 0) {
        add(LoadUnit(rusunId, buildingId, 1, floor));
      } else {
        add(LoadUnit(rusunId, buildingId, pageKey ~/ limit, floor));
      }
    });
    pagingController.refresh();
  }

  PagingController<int, RusunUnit> pagingController =
      PagingController(firstPageKey: 0);
  
  final limit = 20;

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
      yield RusunUnitSuccess(response);
    } catch (e) {
      yield RusunUnitError();
    }
  }
}
