import 'dart:async';

import 'package:amirta_mobile/data/error_message.dart';
import 'package:amirta_mobile/repository/account_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'change_password_event.dart';

part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final AccountRepository accountRepository;

  ChangePasswordBloc(this.accountRepository) : super(ChangePasswordInitial());

  @override
  Stream<ChangePasswordState> mapEventToState(
    ChangePasswordEvent event,
  ) async* {
    switch (event.runtimeType) {
      case ResetPassword:
        yield* resetPassword(event as ResetPassword);
        break;
      case ChangePassword:
        yield* changePassword(event as ChangePassword);
        break;
    }
  }

  Stream<ChangePasswordState> resetPassword(ResetPassword event) async* {
    try {
      yield ChangePasswordLoading();
      final response = await accountRepository.changePassword(
          event.newPassword, event.confirmPassword);
      yield ChangePasswordSuccess();
    } catch (e) {
      final error = e as ErrorMessage;
      yield ChangePasswordError(error.message ?? 'Gagal mengganti password');
    }
  }
  
  Stream<ChangePasswordState> changePassword(ChangePassword event) async* {
    try {
      yield ChangePasswordLoading();
      final response = await accountRepository.changePassword(
          event.currentPassword, event.confirmPassword);
      yield ChangePasswordSuccess();
    } catch (e) {
      final error = e as ErrorMessage;
      yield ChangePasswordError(error.message ?? 'Gagal mengganti password');
    }
  }
}
