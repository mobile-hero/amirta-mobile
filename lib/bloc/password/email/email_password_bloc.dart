import 'dart:async';

import 'package:amirta_mobile/data/error_message.dart';
import 'package:amirta_mobile/repository/account_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'email_password_event.dart';

part 'email_password_state.dart';

class EmailPasswordBloc extends Bloc<EmailPasswordEvent, EmailPasswordState> {
  final AccountRepository accountRepository;

  EmailPasswordBloc(this.accountRepository) : super(EmailPasswordInitial());

  @override
  Stream<EmailPasswordState> mapEventToState(
    EmailPasswordEvent event,
  ) async* {
    if (event is SendResetEmail) {
      yield* sendEmail(event);
    }
  }

  Stream<EmailPasswordState> sendEmail(
    SendResetEmail event,
  ) async* {
    try {
      yield EmailPasswordLoading();
      final response = await accountRepository.forgotPassword(event.email);
      yield EmailPasswordSuccess();
    } catch (e) {
      final error = e as ErrorMessage;
      yield EmailPasswordError(error.message ?? 'Gagal reset kata sandi');
    }
  }
}
