import 'dart:async';

import 'package:amirta_mobile/data/rusun/rusun_export.dart';
import 'package:amirta_mobile/objectbox.g.dart';
import 'package:amirta_mobile/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';

part 'rusun_blok_event.dart';

part 'rusun_blok_state.dart';

class RusunBlokBloc extends Bloc<RusunBlokEvent, RusunBlokState> {
  final RusunRepository rusunRepository;
  final int rusunId;

  RusunBlokBloc(this.rusunRepository, this.rusunId)
      : super(RusunBlokInitial()) {
    add(LoadBlok(rusunId));
  }

  PagingController<int, RusunBlok> pagingController =
      PagingController(firstPageKey: 0);

  @override
  Stream<RusunBlokState> mapEventToState(
    RusunBlokEvent event,
  ) async* {
    if (event is LoadBlok) {
      yield* getBlok(event);
    }
  }

  Stream<RusunBlokState> getBlok(LoadBlok event) async* {
    try {
      yield RusunBlokLoading();
      final store = await openStore();
      final box = store.box<RusunBlok>();
      final result = box
          .query(
            RusunBlok_.rusunId.equals(rusunId),
          )
          .build()
          .find();
      store.close();
      if (result.isNotEmpty) {
        pagingController.appendLastPage(result);
        yield RusunBlokSuccess(result);
        return;
      }

      final response = await rusunRepository.getBlok(event.rusunId);
      pagingController.appendLastPage(response.data);
      yield RusunBlokSuccess(response.data);
    } catch (e) {
      yield RusunBlokError();
    }
  }
}
