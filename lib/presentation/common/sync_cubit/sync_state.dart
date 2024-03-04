part of 'sync_cubit.dart';

@immutable
sealed class SyncState {}

final class SyncInitialState extends SyncState {}

final class SyncLoadingState extends SyncState {}

final class SyncErrorState extends SyncState {
  final String message;
  SyncErrorState(this.message);
}

final class SyncSyncedState extends SyncState {}

final class SyncHasUpdatesPendingState extends SyncState {}
