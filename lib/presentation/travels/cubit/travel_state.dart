part of 'travel_cubit.dart';

@immutable
sealed class TravelState {}

final class TravelInitialState extends TravelState {}

final class TravelLoadingState extends TravelState {}

final class TravelLoadedState extends TravelState {
  final List<Travel> travels;
  TravelLoadedState(this.travels);
}

final class TravelErrorState extends TravelState {
  final String message;
  TravelErrorState(this.message);
}
