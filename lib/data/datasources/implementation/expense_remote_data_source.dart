import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:onfly/data/datasources/remote/expense_data_source.dart';
import 'package:onfly/domain/entities/expense.dart';
import 'package:onfly/domain/entities/user_app.dart';

class RemoteExpenseDataSource implements ExpenseDataSource {
  @override
  Future<Expense> editExpense(
      {required UserApp userApp, required Expense expense}) async {
    final DatabaseReference ref =
        FirebaseDatabase.instance.ref('${userApp.id}/expenses/${expense.id}');

    try {
      await ref.set(expense);
      return expense;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Expense> getExpenseData(
      {required UserApp userApp, required Expense expense}) async {
    final DatabaseReference ref =
        FirebaseDatabase.instance.ref('${userApp.id}/expenses/${expense.id}');

    try {
      final expenseDataSnapshot = await ref.get();
      expense =
          Expense.fromJson(jsonDecode(expenseDataSnapshot.value as String));
      return expense;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Expense>> getExpenses({required UserApp userApp}) async {
    List<Expense> expenses = [];
    final DatabaseReference ref =
        FirebaseDatabase.instance.ref('${userApp.id}/expenses');

    try {
      final expensesSnapshot = await ref.get();
      for (var expense in expensesSnapshot.value as List) {
        expenses.add(Expense.fromJson(jsonDecode(expense)));
      }
      return expenses;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Expense>> updateExpenses(
      {required UserApp userApp, required List<Expense> expenses}) async {
    final DatabaseReference ref =
        FirebaseDatabase.instance.ref('${userApp.id}/expenses');
    try {
      final expensesSnapshot = await ref.get();
      if (expenses == expensesSnapshot.value as List ||
          expenses.length > (expensesSnapshot.value as List).length) {
        await ref.set(expenses);
      } else {
        expenses = await getExpenses(userApp: userApp);
      }
      return expenses;
    } catch (e) {
      rethrow;
    }
  }
}
