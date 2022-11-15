import 'dart:async';

import 'package:amirta_mobile/bloc/app_provider.dart';
import 'package:amirta_mobile/data/account/account_export.dart';
import 'package:amirta_mobile/repository/account_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AccountRepository accountRepository;
  final AppProvider appProvider;

  ProfileBloc(this.accountRepository, this.appProvider)
      : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is LoadAccount) {
      try {
        yield ProfileLoading();
        final response = await accountRepository.getProfile();
        appProvider.setUser(response.data);
        yield ProfileSuccess();
      } catch (e) {
        yield ProfileError();
      }
    } else if (event is SaveAccount) {
      try {
        yield ProfileLoading();
        final _ = await accountRepository.editProfile(EditProfile(
          mobilePhoneNumber: event.phone,
          emailAddress: event.email,
        ));
        add(LoadAccount());
      } catch (e) {
        yield ProfileError();
      }
    }
  }
}
