import 'dart:async';

import 'package:amirta_mobile/data/pengaduan/pengaduan.dart';
import 'package:amirta_mobile/repository/pengaduan_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';

part 'complaint_list_event.dart';

part 'complaint_list_state.dart';

class ComplaintListBloc extends Bloc<ComplaintListEvent, ComplaintListState> {
  final PengaduanRepository pengaduanRepository;
  final int listType;
  final int status;

  ComplaintListBloc(this.pengaduanRepository, this.listType, this.status)
      : super(ComplaintListInitial()) {
    pagingController.addPageRequestListener((pageKey) {
      if (pageKey == 0) {
        add(LoadComplaint(status));
      } else if (pageKey >= 0) {
        add(LoadMoreComplaint(status, pageKey));
      }
    });
  }

  final PagingController<int, Pengaduan> pagingController =
      PagingController(firstPageKey: 0);
  final limit = 20;

  @override
  Stream<ComplaintListState> mapEventToState(
    ComplaintListEvent event,
  ) async* {
    switch (event.runtimeType) {
      case LoadComplaint:
        yield* loadComplaint(event as LoadComplaint);
        break;
      case LoadMoreComplaint:
        yield* loadMoreComplaint(event as LoadMoreComplaint);
        break;
    }
  }

  Stream<ComplaintListState> loadComplaint(LoadComplaint event) async* {
    try {
      yield ComplaintListLoading();
      final response = await pengaduanRepository.getList(
        listType,
        event.status,
        1,
        limit,
      );
      if (response.length < limit) {
        pagingController.appendLastPage(response.data);
      } else {
        pagingController.appendPage(response.data, 1);
      }
      yield ComplaintListSuccess();
    } catch (e) {
      print(e);
      yield ComplaintListError();
    }
  }

  Stream<ComplaintListState> loadMoreComplaint(LoadMoreComplaint event) async* {
    try {
      yield ComplaintListLoading();
      final response = await pengaduanRepository.getList(
        listType,
        event.status,
        event.nextPageKey,
        limit,
      );
      if (response.length < limit) {
        pagingController.appendLastPage(response.data);
      } else {
        pagingController.appendPage(response.data, event.nextPageKey + 1);
      }
      yield ComplaintListSuccess();
    } catch (e) {
      yield ComplaintListError();
    }
  }
}
