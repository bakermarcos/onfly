part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitialState extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomePopBottomSheetState extends HomeState {}

final class HomeLoadedState extends HomeState {
  final List<Expense> expenses;
  HomeLoadedState(this.expenses);
}

final class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState(this.message);
}
