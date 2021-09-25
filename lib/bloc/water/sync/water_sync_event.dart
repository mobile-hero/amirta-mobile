part of 'water_sync_bloc.dart';

@immutable
abstract class WaterSyncEvent {}

class LoadTotalUnsynced extends WaterSyncEvent {}

class UploadSavedData extends WaterSyncEvent {}
