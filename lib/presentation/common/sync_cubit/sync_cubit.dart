import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:onfly/data/datasources/implementation/api/card_remote_data_source_api.dart';
import 'package:onfly/data/datasources/implementation/api/expense_remote_data_source_api.dart';
import 'package:onfly/data/datasources/implementation/local/card_remote_data_source_local.dart';
import 'package:onfly/data/datasources/implementation/local/expense_remote_data_source_local.dart';
import 'package:onfly/data/datasources/remote/api/card_data_source_api.dart';
import 'package:onfly/data/datasources/remote/api/expense_data_source_api.dart';
import 'package:onfly/data/datasources/remote/local/card_data_source_local.dart';
import 'package:onfly/data/datasources/remote/local/expense_data_source_local.dart';
import 'package:onfly/data/repositories/implementation/card_repository_imp.dart';
import 'package:onfly/data/repositories/implementation/expense_repository_imp.dart';
import 'package:onfly/data/repositories/repositories/card_repository.dart';
import 'package:onfly/data/repositories/repositories/expense_repository.dart';
import 'package:onfly/domain/entities/corporate_card.dart';
import 'package:onfly/domain/entities/expense.dart';
import 'package:onfly/domain/entities/user_app.dart';
import 'package:onfly/domain/usecases/card/update_balance_usecase.dart';
import 'package:onfly/domain/usecases/expense/update_expenses_usecase.dart';

part 'sync_state.dart';

class SyncCubit extends Cubit<SyncState> {
  final CardDataSourceApi _cardDataSourceApi =
      RemoteCardDataSourceApi(FirebaseDatabase.instance);
  late final CardDataSourceLocal _cardDataSourceLocal;
  late final CardRepository _cardRepository;
  late final UpdateBalanceUseCase _updateBalanceUseCase;

  final ExpenseDataSourceApi _expenseDataSourceApi =
      RemoteExpenseDataSourceApi(FirebaseDatabase.instance);
  late final ExpenseDataSourceLocal _expenseDataSourceLocal;
  late final ExpenseRepository _expenseRepository;
  late final UpdateExpensesUseCase _updateExpensesUseCase;

  late UserApp _userApp;
  UserApp get userApp => _userApp;

  late CorporateCard _card;
  CorporateCard get card => _card;

  late List<Expense> _expenses;
  List<Expense> get expenses => _expenses;
  bool hasPendingExpensesUpdates = false;
  bool hasPendingCardUpdates = false;
  SyncCubit() : super(SyncInitialState());

  Future<void> init() async {
    _expenseDataSourceLocal = RemoteExpenseDataSourceLocal(
        Hive.box<Expense>('expenses'), Hive.box<Expense>('sync_expenses'));
    _cardDataSourceLocal = RemoteCardDataSourceLocal(
        Hive.box<CorporateCard>('card_data'),
        Hive.box<CorporateCard>('sync_card_data'));
        
    _cardRepository =
        CardRepositoryImp(_cardDataSourceApi, _cardDataSourceLocal);
    _updateBalanceUseCase = UpdateBalanceUseCase(_cardRepository);

    _expenseRepository =
        ExpenseRepositoryImp(_expenseDataSourceApi, _expenseDataSourceLocal);
    _updateExpensesUseCase = UpdateExpensesUseCase(_expenseRepository);
    _userApp = Hive.box<UserApp>('user_data').values.first;
    _card = Hive.box<CorporateCard>('card_data').values.isNotEmpty
        ? Hive.box<CorporateCard>('card_data').values.first
        : CorporateCard.empty();
    _expenses = Hive.box<Expense>('expenses').values.toList();
  }

  void calculateNewBalance() {
    double outcomes = 0;
    for (var expense in expenses) {
      outcomes += double.tryParse(expense.value.replaceAll(',', '.')) ?? 0;
    }
    _card.balance = _card.initialBalance - outcomes;
  }

  Future<void> update() async {
    emit(SyncLoadingState());

    if (await checkPendingUpdates()) {
      if (hasPendingExpensesUpdates) {
        await updateExpenses();
      }
      if (hasPendingCardUpdates) {
        await updateBalance();
      }
    } else {
      emit(SyncErrorState('Você não tem nenhuma pendência'));
    }
  }

  Future<void> updateBalance() async {
    emit(SyncLoadingState());
    calculateNewBalance();
    try {
      _card.balance = await _updateBalanceUseCase.call(
          userApp: _userApp, balance: _card.balance, card: _card);
    } catch (e) {
      emit(SyncErrorState(e.toString()));
    }
    emit(SyncSyncedState());
  }

  Future<void> updateExpenses() async {
    emit(SyncLoadingState());
    try {
      _expenses = await _updateExpensesUseCase.call(
          userApp: _userApp, expenses: _expenses);
    } catch (e) {
      emit(SyncErrorState(e.toString()));
    }
    emit(SyncSyncedState());
  }

  Future<bool> checkPendingUpdates() async {
    hasPendingExpensesUpdates =
        Hive.box<Expense>('sync_expenses').values.isNotEmpty;
    hasPendingCardUpdates =
        Hive.box<CorporateCard>('sync_card_data').values.isNotEmpty;
    return hasPendingExpensesUpdates || hasPendingCardUpdates;
  }
}
