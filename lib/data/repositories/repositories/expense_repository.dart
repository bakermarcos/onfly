import 'package:onfly/domain/entities/expense.dart';
import 'package:onfly/domain/entities/user_app.dart';

abstract class ExpenseRepository {
  Future<Expense> getExpenseData(
      {required UserApp userApp, required Expense expense});

  Future<List<Expense>> getExpenses({required UserApp userApp});

  Future<Expense> editExpense(
      {required UserApp userApp, required Expense expense});

  Future<List<Expense>> updateExpenses(
      {required UserApp userApp, required List<Expense> expenses});
}
