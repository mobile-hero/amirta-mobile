import 'dart:async';

import 'package:amirta_mobile/data/rusun/rusun_export.dart';
import 'package:amirta_mobile/repository/rusun_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';

part 'rusun_event.dart';

part 'rusun_state.dart';

class RusunBloc extends Bloc<RusunEvent, RusunState> {
  final RusunRepository rusunRepository;

  RusunBloc(this.rusunRepository) : super(RusunInitial()) {
    add(LoadRusun());
  }

  PagingController<int, Rusun> pagingController =
      PagingController(firstPageKey: 0);

  @override
  Stream<RusunState> mapEventToState(
    RusunEvent event,
  ) async* {
    if (event is LoadRusun) {
      yield* getRusun(event);
    }
  }

  Stream<RusunState> getRusun(LoadRusun event) async* {
    try {
      yield RusunLoading();
      final response = await rusunRepository.getRusunawa();
      pagingController.appendLastPage(response.data);
      yield RusunSuccess(response);
    } catch (e) {
      yield RusunError();
    }
  }
}
