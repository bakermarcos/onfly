import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:onfly/data/datasources/remote/api/expense_data_source_api.dart';
import 'package:onfly/domain/entities/expense.dart';
import 'package:onfly/domain/entities/user_app.dart';

class RemoteExpenseDataSourceApi implements ExpenseDataSourceApi {
  final FirebaseDatabase _firebaseDatabase;
  RemoteExpenseDataSourceApi(this._firebaseDatabase);
  @override
  Future<Expense> editExpense(
      {required UserApp userApp, required Expense expense}) async {
    final DatabaseReference ref =
        _firebaseDatabase.ref('${userApp.id}/expenses/${expense.id}');

    try {
      await ref.set(expense.toMap()).timeout(const Duration(seconds: 5));
      return expense;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Expense> getExpenseData(
      {required UserApp userApp, required Expense expense}) async {
    final DatabaseReference ref =
        _firebaseDatabase.ref('${userApp.id}/expenses/${expense.id}');

    try {
      final expenseDataSnapshot = await ref.get().timeout(const Duration(seconds: 5));
      expense = Expense.fromJson(expenseDataSnapshot.value as String);
      return expense;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Expense>> getExpenses({required UserApp userApp}) async {
    List<Expense> expenses = [];
    final DatabaseReference ref =
        _firebaseDatabase.ref('${userApp.id}/expenses');

    try {
      final expensesSnapshot = await ref.get().timeout(const Duration(seconds: 5));
      final auxList = (expensesSnapshot.value as List);

      for (var expense in auxList) {
        expenses.add(Expense.fromJson((jsonEncode(expense))));
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
        _firebaseDatabase.ref('${userApp.id}/expenses');
    try {
      final expensesSnapshot = await ref.get().timeout(const Duration(seconds: 5));
      final auxList = (expensesSnapshot.value as List);

      if (expenses == auxList || expenses.length > auxList.length) {
        List auxList = [];
        for (var element in expenses) {
          auxList.add(element.toMap());
        }
        Map auxMap = auxList.asMap();
        await ref.set(auxMap);
      } else {
        expenses = await getExpenses(userApp: userApp);
      }
      return expenses;
    } catch (e) {
      rethrow;
    }
  }
}
