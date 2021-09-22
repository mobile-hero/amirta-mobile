import 'dart:async';

import 'package:amirta_mobile/data/account/user_notification.dart';
import 'package:amirta_mobile/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final AccountRepository accountRepository;

  NotificationBloc(this.accountRepository) : super(NotificationInitial());

  final PagingController<int, UserNotification> pagingController =
      PagingController(firstPageKey: 0);

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    if (event is LoadNotification) {
      try {
        yield NotificationLoading();
        final response = await accountRepository.notifications();
        pagingController.appendLastPage(response.data);
        yield NotificationSuccess();
      } catch (e) {
        yield NotificationError();
      }
    }
  }
}
