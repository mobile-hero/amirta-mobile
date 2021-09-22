part of 'fcm_bloc.dart';

@immutable
abstract class FcmEvent {}

class RegisterFcm extends FcmEvent {}

class RefreshFcmId extends FcmEvent {
  final String fcmid;

  RefreshFcmId(this.fcmid);
}
