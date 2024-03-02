part of 'expense_cubit.dart';

@immutable
sealed class ExpenseState {}

final class ExpenseInitialState extends ExpenseState {}

final class ExpenseLoadingState extends ExpenseState {}

final class ExpenseEditingState extends ExpenseState {}

final class ExpenseLoadedState extends ExpenseState {
  final Expense expense;
  ExpenseLoadedState(this.expense);
}

final class ExpenseErrorState extends ExpenseState {
  final String message;
  ExpenseErrorState(this.message);
}
