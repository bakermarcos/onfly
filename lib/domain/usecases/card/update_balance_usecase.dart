import 'package:onfly/data/repositories/repositories/card_repository.dart';
import 'package:onfly/domain/entities/corporate_card.dart';
import 'package:onfly/domain/entities/user_app.dart';

class UpdateBalanceUseCase {
  final CardRepository cardRepository;
  UpdateBalanceUseCase(this.cardRepository);
  Future<int> call(
      {required UserApp userApp,
      required int balance,
      required CorporateCard card}) async {
    return await cardRepository.updateBalance(
        userApp: userApp, balance: balance, card: card);
  }
}
