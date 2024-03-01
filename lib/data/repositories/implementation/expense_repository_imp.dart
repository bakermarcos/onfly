import 'package:onfly/data/datasources/remote/expense_data_source.dart';
import 'package:onfly/data/repositories/repositories/expense_repository.dart';
import 'package:onfly/domain/entities/expense.dart';
import 'package:onfly/domain/entities/user_app.dart';

class ExpenseRepositoryImp implements ExpenseRepository {
  final ExpenseDataSource expenseDataSource;
  ExpenseRepositoryImp(this.expenseDataSource);
  @override
  Future<Expense> editExpense(
      {required UserApp userApp, required Expense expense}) async {
    return await expenseDataSource.editExpense(
        userApp: userApp, expense: expense);
  }

  @override
  Future<Expense> getExpenseData(
      {required UserApp userApp, required Expense expense}) async {
    return await expenseDataSource.getExpenseData(
        userApp: userApp, expense: expense);
  }

  @override
  Future<List<Expense>> getExpenses({required UserApp userApp}) async {
    return await expenseDataSource.getExpenses(userApp: userApp);
  }

  @override
  Future<List<Expense>> updateExpenses(
      {required UserApp userApp, required List<Expense> expenses}) async {
    return await expenseDataSource.updateExpenses(
        userApp: userApp, expenses: expenses);
  }
}
