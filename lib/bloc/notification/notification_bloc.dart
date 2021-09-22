import 'dart:async';

import 'package:amirta_mobile/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final AccountRepository accountRepository;

  NotificationBloc(this.accountRepository) : super(NotificationInitial());

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    if (event is LoadNotification) {
      try {
        yield NotificationLoading();
        final response = await accountRepository.notifications();
        yield NotificationSuccess();
      } catch (e) {
        yield NotificationError();
      }
    }
  }
}
