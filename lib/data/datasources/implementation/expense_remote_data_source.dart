

import 'package:onfly/data/datasources/remote/expense_data_source.dart';
import 'package:onfly/domain/entities/expense.dart';

class RemoteExpenseDataSource implements ExpenseDataSource {
  @override
  Future<String> editExpense({required Expense expense}) {
    // TODO: implement editExpense
    throw UnimplementedError();
  }

  @override
  Future<Expense> getExpenseData() {
    // TODO: implement getExpenseData
    throw UnimplementedError();
  }

  @override
  Future<List<Expense>> getExpenses() {
    // TODO: implement getExpenses
    throw UnimplementedError();
  }

  @override
  Future<List<Expense>> updateExpenses({required List<Expense> expenses}) {
    // TODO: implement updateExpenses
    throw UnimplementedError();
  }
  
}
