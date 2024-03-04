import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onfly/data/datasources/implementation/local/expense_remote_data_source_local.dart';
import 'package:onfly/data/datasources/remote/local/expense_data_source_local.dart';
import 'package:onfly/domain/entities/expense.dart';

class HiveBoxMock<E> extends Mock implements Box<E> {}

void main() {
  late final ExpenseDataSourceLocal expenseDataSourceLocal;
  Box<Expense> expenseBox = HiveBoxMock<Expense>();
  Box<Expense> expenseBoxSync = HiveBoxMock<Expense>();
  List<Expense> expenses = [];

  setUp(() async {
    registerFallbackValue(
      Expense(
          id: 1,
          name: 'name',
          value: 'value',
          date: 'date',
          category: 'category'),
    );
    expenseDataSourceLocal =
        RemoteExpenseDataSourceLocal(expenseBox, expenseBoxSync);
  });

  test('Deve receber uma lista de despesas', () async {
    expenses = [
      Expense(
          id: 0,
          name: 'name',
          value: 'value',
          date: 'date',
          category: 'category'),
      Expense(
          id: 1,
          name: 'name',
          value: 'value',
          date: 'date',
          category: 'category')
    ];

    when(() => expenseBox.values).thenReturn(expenses);

    final result = await expenseDataSourceLocal.getExpenses();
    expect(result, expenses);
  });

  test('Deve editar uma despesa com sincronização', () async {
    // Arrange
    expenses = [
      Expense(
          id: 0,
          name: 'name',
          value: 'value',
          date: 'date',
          category: 'category'),
      Expense(
          id: 1,
          name: 'name',
          value: 'value',
          date: 'date',
          category: 'category')
    ];

    when(() => expenseBox.values).thenReturn(expenses);
    when(() => expenseBoxSync.addAll(any()))
        .thenAnswer((invocation) async => []);
    when(() => expenseBox.clear()).thenAnswer((invocation) async => 0);
    when(() => expenseBox.addAll(any())).thenAnswer((invocation) async => []);

    when(() => expenseBox.get(any()))
        .thenAnswer((invocation) => expenses.first);
    when(() => expenseBox.put(any(), any())).thenAnswer((invocation) async {});
    // act

    final result = await expenseDataSourceLocal.editExpense(
        expense: expenses.first, isSync: true);

    //assert
    expect(result.id, expenses.first.id);
    verify(
      () => expenseBoxSync.addAll(any()),
    ).called(1);
  });
}
