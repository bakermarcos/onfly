import 'package:onfly/domain/entities/expense.dart';

abstract class ExpenseDataSource {
 Future<Expense> getExpenseData();

 Future<List<Expense>> getExpenses();

 Future<String> editExpense({required Expense expense});

 Future<List<Expense>> updateExpenses({required List<Expense> expenses});
}