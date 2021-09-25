part of 'water_sync_bloc.dart';

@immutable
abstract class WaterSyncState {
  final int totalUnsynced;
  
  WaterSyncState(this.totalUnsynced);
}

class WaterSyncInitial extends WaterSyncState {
  WaterSyncInitial(int totalUnsynced) : super(totalUnsynced);
}

class WaterUnsyncLoaded extends WaterSyncState {
  WaterUnsyncLoaded(int totalUnsynced) : super(totalUnsynced);
}

class WaterSyncLoading extends WaterSyncState {
  WaterSyncLoading(int totalUnsynced) : super(totalUnsynced);
}

class WaterSyncProgress extends WaterSyncState {
  final double progress;
  
  WaterSyncProgress(this.progress, int totalUnsynced) : super(totalUnsynced);
}

class WaterSyncSuccess extends WaterSyncState {
  WaterSyncSuccess(int totalUnsynced) : super(totalUnsynced);
}

class WaterSyncError extends WaterSyncState {
  final String message;
  WaterSyncError(this.message, int totalUnsynced) : super(totalUnsynced);
}
