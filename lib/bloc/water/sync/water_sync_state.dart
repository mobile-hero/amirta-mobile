part of 'water_sync_bloc.dart';

@immutable
abstract class WaterSyncState {
  final int totalUnsynced;

  const WaterSyncState(this.totalUnsynced);
}

class WaterSyncInitial extends WaterSyncState {
  const WaterSyncInitial(int totalUnsynced) : super(totalUnsynced);
}

class WaterUnsyncLoaded extends WaterSyncState {
  const WaterUnsyncLoaded(int totalUnsynced) : super(totalUnsynced);
}

class WaterSyncLoading extends WaterSyncState {
  const WaterSyncLoading(int totalUnsynced) : super(totalUnsynced);
}

class WaterSyncProgress extends WaterSyncState {
  final double progress;

  const WaterSyncProgress(this.progress, int totalUnsynced)
      : super(totalUnsynced);
}

class WaterSyncSuccess extends WaterSyncState {
  const WaterSyncSuccess(int totalUnsynced) : super(totalUnsynced);
}

class WaterSyncError extends WaterSyncState {
  final String message;

  const WaterSyncError(this.message, int totalUnsynced) : super(totalUnsynced);
}
