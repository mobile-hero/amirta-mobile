import 'dart:async';

import 'package:amirta_mobile/bloc/app_provider.dart';
import 'package:amirta_mobile/data/account/login_write.dart';
import 'package:amirta_mobile/repository/account_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AccountRepository accountRepository;
  final AppProvider appProvider;

  LoginBloc(this.accountRepository, this.appProvider)
      : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginNow) {
      try {
        yield LoginLoading();
        final response = await accountRepository.login(LoginWrite(
          loginType: 0,
          userid: event.nrk,
          passwd: event.password,
          emailAddress: '',
          loginId: '',
          name: '',
        ));
        await appProvider.setUser(response.data);
        yield LoginSuccess();
      } catch (e) {
        yield LoginError();
      }
    }
  }
}
