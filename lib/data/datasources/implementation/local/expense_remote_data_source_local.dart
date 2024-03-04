import 'package:hive/hive.dart';
import 'package:onfly/data/datasources/remote/local/expense_data_source_local.dart';
import 'package:onfly/domain/entities/expense.dart';

class RemoteExpenseDataSourceLocal implements ExpenseDataSourceLocal {
  final Box<Expense> expenseBox = Hive.box<Expense>('expenses');
  final Box<Expense> syncExpenseBox = Hive.box<Expense>('sync_expenses');
  @override
  Future<Expense> editExpense(
      {required Expense expense, bool isSync = false}) async {
    Expense? expenseLocal = expenseBox.get(expense);

    if (expenseLocal != null) {
      expenseLocal = expense;
      await expenseBox.put(expenseLocal.id, expenseLocal);
      if (isSync) {
        updateExpenses(expenses: await getExpenses(), isSync: isSync);
      } else {
        await syncExpenseBox.clear();
      }
      return expenseLocal;
    }
    return expense;
  }

  @override
  Future<Expense> getExpenseData({required Expense expense}) async {
    return expenseBox.get(expense) ?? expense;
  }

  @override
  Future<List<Expense>> getExpenses() async {
    return expenseBox.values.toList();
  }

  @override
  Future<List<Expense>> updateExpenses(
      {required List<Expense> expenses, bool isSync = false}) async {
    if (isSync) {
      await syncExpenseBox.addAll(expenses);
    } else {
      syncExpenseBox.clear();
    }
    await expenseBox.clear();
    await expenseBox.addAll(expenses);
    return expenses;
  }
}
