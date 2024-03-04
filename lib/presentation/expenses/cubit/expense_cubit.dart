import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:onfly/data/datasources/implementation/api/expense_remote_data_source_api.dart';
import 'package:onfly/data/datasources/implementation/local/expense_remote_data_source_local.dart';
import 'package:onfly/data/datasources/remote/api/expense_data_source_api.dart';
import 'package:onfly/data/datasources/remote/local/expense_data_source_local.dart';
import 'package:onfly/data/repositories/implementation/expense_repository_imp.dart';
import 'package:onfly/data/repositories/repositories/expense_repository.dart';
import 'package:onfly/domain/entities/expense.dart';
import 'package:onfly/domain/entities/user_app.dart';
import 'package:onfly/domain/usecases/expense/edit_expense_usecase.dart';
import 'package:onfly/domain/usecases/expense/get_expense_data_usecase.dart';
import 'package:onfly/domain/usecases/expense/get_expenses_usecase.dart';
import 'package:onfly/domain/usecases/expense/update_expenses_usecase.dart';
// import 'package:onfly/domain/usecases/expense/get_expenses_usecase.dart';
// import 'package:onfly/domain/usecases/expense/update_expenses_usecase.dart';

part 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final ExpenseDataSourceApi _expenseDataSourceApi =
      RemoteExpenseDataSourceApi(FirebaseDatabase.instance);
  final ExpenseDataSourceLocal _expenseDataSourceLocal =
      RemoteExpenseDataSourceLocal();
  late final ExpenseRepository _expenseRepository;
  late final GetExpenseDataUseCase _getExpenseDataUseCase;
  late final UpdateExpensesUseCase _updateExpensesUseCase;
  late final EditExpenseUseCase _editExpenseUseCase;
  late final GetExpensesUseCase _getExpensesUseCase;
  late UserApp _userApp;
  UserApp get userApp => _userApp;
  late Expense _expense;
  Expense get expense => _expense;
  late List<Expense> _expenses;
  List<Expense> get expenses => _expenses;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  ExpenseCubit() : super(ExpenseInitialState());

  void init(Expense expense) async {
    _expenseRepository =
        ExpenseRepositoryImp(_expenseDataSourceApi, _expenseDataSourceLocal);
    _getExpenseDataUseCase = GetExpenseDataUseCase(_expenseRepository);
    _updateExpensesUseCase = UpdateExpensesUseCase(_expenseRepository);
    _editExpenseUseCase = EditExpenseUseCase(_expenseRepository);
    _getExpensesUseCase = GetExpensesUseCase(_expenseRepository);
    _userApp = Hive.box<UserApp>('user_data').values.first;
    _expenses = Hive.box<Expense>('expenses').values.toList();
    _expense = Hive.box<Expense>('expenses').get(expense) ?? expense;
  }

  Future<void> updateDatabase() async {
    await updateExpenses().then((value) async => getExpenses());
  }

  Future<void> getExpenseData(Expense expense) async {
    emit(ExpenseLoadingState());
    try {
      _expense = await _getExpenseDataUseCase.call(
          userApp: _userApp, expense: expense);
    } catch (e) {
      emit(ExpenseErrorState(e.toString()));
    }
    emit(ExpenseLoadedState(expense));
  }

  Future<void> updateExpenses() async {
    emit(ExpenseLoadingState());
    try {
      await _updateExpensesUseCase.call(userApp: _userApp, expenses: _expenses);
    } catch (e) {
      emit(ExpenseErrorState(e.toString()));
    }
    emit(ExpenseLoadedState(expense));
  }

  Future<void> getExpenses() async {
    emit(ExpenseLoadingState());
    try {
      await _getExpensesUseCase.call(userApp: _userApp);
    } catch (e) {
      emit(ExpenseErrorState(e.toString()));
    }
    emit(ExpenseLoadedState(expense));
  }

  void isEditing() {
    emit(ExpenseEditingState());
  }

  Future<void> editExpense() async {
    emit(ExpenseLoadingState());
    final expenseEdited = Expense(
        id: _expense.id,
        name: nameController.text,
        date: dateController.text,
        value: valueController.text,
        category: categoryController.text);
    try {
      _expense = await _editExpenseUseCase.call(
          userApp: _userApp, expense: expenseEdited);
      await updateDatabase();
    } catch (e) {
      emit(ExpenseErrorState(e.toString()));
    }
    emit(ExpenseLoadedState(expense));
  }
}
