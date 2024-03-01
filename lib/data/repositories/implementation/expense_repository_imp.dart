import 'package:onfly/data/datasources/remote/api/expense_data_source_api.dart';
import 'package:onfly/data/datasources/remote/local/expense_data_source_local.dart';
import 'package:onfly/data/repositories/repositories/expense_repository.dart';
import 'package:onfly/domain/entities/expense.dart';
import 'package:onfly/domain/entities/user_app.dart';

class ExpenseRepositoryImp implements ExpenseRepository {
  final ExpenseDataSourceApi expenseDataSourceApi;
  final ExpenseDataSourceLocal expenseDataSourceLocal;
  ExpenseRepositoryImp(this.expenseDataSourceApi, this.expenseDataSourceLocal);
  @override
  Future<Expense> editExpense(
      {required UserApp userApp, required Expense expense}) async {
    Expense response;
    try {
      response = await expenseDataSourceApi.editExpense(
          userApp: userApp, expense: expense);
      await expenseDataSourceLocal.editExpense(expense: response);
    } catch (e) {
      response = await expenseDataSourceLocal.editExpense(
          expense: expense, isSync: true);
      rethrow;
    }
    return response;
  }

  @override
  Future<Expense> getExpenseData(
      {required UserApp userApp, required Expense expense}) async {
    Expense response;
    try {
      response = await expenseDataSourceApi.getExpenseData(
          userApp: userApp, expense: expense);
      await expenseDataSourceLocal.editExpense(expense: response);
    } catch (e) {
      response = await expenseDataSourceLocal.getExpenseData(expense: expense);
      rethrow;
    }
    return response;
  }

  @override
  Future<List<Expense>> getExpenses({required UserApp userApp}) async {
    List<Expense> response;
    try {
      response = await expenseDataSourceApi.getExpenses(userApp: userApp);
      await expenseDataSourceLocal.updateExpenses(expenses: response);
    } catch (e) {
      response = await expenseDataSourceLocal.getExpenses();
      rethrow;
    }
    return response;
  }

  @override
  Future<List<Expense>> updateExpenses(
      {required UserApp userApp, required List<Expense> expenses}) async {
    List<Expense> response;
    try {
      response = await expenseDataSourceApi.updateExpenses(
          userApp: userApp, expenses: expenses);
      await expenseDataSourceLocal.updateExpenses(expenses: response);
    } catch (e) {
      response = await expenseDataSourceLocal.updateExpenses(
          expenses: expenses, isSync: true);
      rethrow;
    }
    return response;
  }
}
