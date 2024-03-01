import 'package:onfly/domain/entities/expense.dart';

abstract class ExpenseDataSourceLocal {
  Future<Expense> getExpenseData({required Expense expense});

  Future<List<Expense>> getExpenses();

  Future<Expense> editExpense({required Expense expense, bool isSync = false});

  Future<List<Expense>> updateExpenses(
      {required List<Expense> expenses, bool isSync = false});
}
