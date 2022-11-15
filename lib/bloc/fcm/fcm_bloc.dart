import 'dart:async';

import 'package:amirta_mobile/repository/fcm_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';

part 'fcm_event.dart';

part 'fcm_state.dart';

class FcmBloc extends Bloc<FcmEvent, FcmState> {
  final FcmRepository fcmRepository;
  final FirebaseMessaging messaging;

  FcmBloc(this.fcmRepository, this.messaging) : super(FcmInitial()) {
    onTokenRefresh = messaging.onTokenRefresh.listen((event) {
      add(RefreshFcmId(event));
    });
  }

  late final StreamSubscription? onTokenRefresh;

  @override
  Future<void> close() {
    onTokenRefresh?.cancel();
    return super.close();
  }

  @override
  Stream<FcmState> mapEventToState(
    FcmEvent event,
  ) async* {
    if (event is RegisterFcm) {
      try {
        final fcmId = await messaging.getToken();
        if (fcmId != null) {
          final _ = await fcmRepository.registerFcmId(fcmId);
        }
      } catch (e) {}
    }
    if (event is RefreshFcmId) {
      try {
        final _ = await fcmRepository.registerFcmId(event.fcmid);
      } catch (e) {}
    }
  }
}
