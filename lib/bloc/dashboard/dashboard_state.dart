part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardSuccess extends DashboardState {
  final Dashboard dashboard;

  DashboardSuccess(this.dashboard);
}

class DashboardError extends DashboardState {}

class DashboardTokenExpired extends DashboardState {}
