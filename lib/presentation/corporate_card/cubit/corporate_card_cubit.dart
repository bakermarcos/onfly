import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:onfly/data/datasources/implementation/api/card_remote_data_source_api.dart';
import 'package:onfly/data/datasources/implementation/local/card_remote_data_source_local.dart';
import 'package:onfly/data/datasources/remote/api/card_data_source_api.dart';
import 'package:onfly/data/datasources/remote/local/card_data_source_local.dart';
import 'package:onfly/data/repositories/implementation/card_repository_imp.dart';
import 'package:onfly/data/repositories/repositories/card_repository.dart';
import 'package:onfly/domain/entities/corporate_card.dart';
import 'package:onfly/domain/entities/expense.dart';
import 'package:onfly/domain/entities/user_app.dart';
import 'package:onfly/domain/usecases/card/get_card_data_usecase.dart';
import 'package:onfly/domain/usecases/card/update_balance_usecase.dart';

part 'corporate_card_state.dart';

class CorporateCardCubit extends Cubit<CorporateCardState> {
  final CardDataSourceApi _cardDataSourceApi =
      RemoteCardDataSourceApi(FirebaseDatabase.instance);
  final CardDataSourceLocal _cardDataSourceLocal = RemoteCardDataSourceLocal();
  late final CardRepository _cardRepository;
  late final GetCardDataUseCase _getCardDataUseCase;
  late final UpdateBalanceUseCase _updateBalanceUseCase;
  late CorporateCard _card;
  CorporateCard get card => _card;
  late UserApp _userApp;
  UserApp get userApp => _userApp;
  late List<Expense> _expenses;
  List<Expense> get expenses => _expenses;
  CorporateCardCubit() : super(InitialCorporateCardState());

  void init() async {
    _cardRepository =
        CardRepositoryImp(_cardDataSourceApi, _cardDataSourceLocal);
    _getCardDataUseCase = GetCardDataUseCase(_cardRepository);
    _updateBalanceUseCase = UpdateBalanceUseCase(_cardRepository);
    _userApp = Hive.box<UserApp>('user_data').values.first;
    _card = Hive.box<CorporateCard>('card_data').values.isNotEmpty
        ? Hive.box<CorporateCard>('card_data').values.first
        : CorporateCard.empty();
    _expenses = Hive.box<Expense>('expenses').values.toList();
    await getCardData().then((value) async => await updateBalance());
  }

  void calculateNewBalance() {
    double outcomes = 0;
    for (var expense in expenses) {
      outcomes += double.tryParse(expense.value.replaceAll(',', '.')) ?? 0;
    }
    _card.balance = _card.initialBalance - outcomes;
  }

  Future<void> updateBalance() async {
    emit(LoadingCorporateCardState());
    calculateNewBalance();
    try {
      await _updateBalanceUseCase.call(
          userApp: _userApp, balance: _card.balance, card: _card);
    } catch (e) {
      emit(ErrorCorporateCardState(e.toString()));
    }
    emit(LoadedCorporateCardState(_card, _expenses));
  }

  Future<void> getCardData() async {
    emit(LoadingCorporateCardState());
    try {
      await _getCardDataUseCase.call(userApp: _userApp, card: _card);
    } catch (e) {
      emit(ErrorCorporateCardState(e.toString()));
    }
    emit(LoadedCorporateCardState(card, _expenses));
  }
}
