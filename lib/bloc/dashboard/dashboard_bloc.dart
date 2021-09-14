import 'dart:async';

import 'package:amirta_mobile/data/account/account_export.dart';
import 'package:amirta_mobile/repository/account_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final AccountRepository accountRepository;

  DashboardBloc(this.accountRepository) : super(DashboardInitial()) {
    add(LoadDashboard());
  }

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if (event is DashboardEvent) {
      yield* loadDashboard(event);
    }
  }

  Stream<DashboardState> loadDashboard(DashboardEvent event) async* {
    try {
      yield DashboardLoading();
      final response = await accountRepository.dashboard();
      yield DashboardSuccess(response.data);
    } catch (e) {
      yield DashboardError();
    }
  }
}
