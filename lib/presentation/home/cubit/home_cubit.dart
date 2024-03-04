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
import 'package:onfly/domain/usecases/expense/get_expenses_usecase.dart';
import 'package:onfly/domain/usecases/expense/update_expenses_usecase.dart';
import 'package:onfly/presentation/common/sync_cubit/sync_cubit.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ExpenseDataSourceApi _expenseDataSourceApi =
      RemoteExpenseDataSourceApi(FirebaseDatabase.instance);
  final ExpenseDataSourceLocal _expenseDataSourceLocal =
      RemoteExpenseDataSourceLocal();
  late final ExpenseRepository _expenseRepository;
  late final UpdateExpensesUseCase _updateExpensesUseCase;
  late final GetExpensesUseCase _getExpensesUseCase;
  late UserApp _userApp;
  UserApp get userApp => _userApp;
  List<Expense> _expenses = [];
  List<Expense> get expenses => _expenses;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final SyncCubit syncCubit = SyncCubit();
  HomeCubit() : super(HomeInitialState());

  void init() async {
    _expenseRepository =
        ExpenseRepositoryImp(_expenseDataSourceApi, _expenseDataSourceLocal);
    _updateExpensesUseCase = UpdateExpensesUseCase(_expenseRepository);
    _getExpensesUseCase = GetExpensesUseCase(_expenseRepository);
    _userApp = Hive.box<UserApp>('user_data').values.first;
    await getExpenses();
    _expenses = Hive.box<Expense>('expenses').values.toList();
  }

  bool _checkExpenseExist(Expense expense) {
    return _expenses.contains(expense);
  }

  Future<void> addExpense() async {
    final newExpense = Expense(
        id: _expenses.length,
        name: nameController.text,
        date: dateController.text,
        value: valueController.text,
        category: categoryController.text);
    if (!_checkExpenseExist(newExpense)) {
      _expenses.add(newExpense);
      emit(HomePopBottomSheetState());
      await updateExpenses();
      emit(HomeLoadedState(expenses));
    } else {
      emit(HomeErrorState('Essa despesa já foi adicionada'));
    }
  }

  Future<void> updateExpenses() async {
    emit(HomeLoadingState());
    try {
      _expenses = await _updateExpensesUseCase.call(
          userApp: _userApp, expenses: _expenses);
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
    emit(HomeLoadedState(_expenses));
  }

  Future<void> getExpenses() async {
    emit(HomeLoadingState());
    try {
      _expenses = await _getExpensesUseCase.call(userApp: _userApp);
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
    emit(HomeLoadedState(expenses));
  }
}
