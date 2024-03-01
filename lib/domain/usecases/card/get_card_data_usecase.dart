import 'package:onfly/data/repositories/repositories/card_repository.dart';
import 'package:onfly/domain/entities/corporate_card.dart';
import 'package:onfly/domain/entities/user_app.dart';

class GetCardDataUseCase {
  final CardRepository cardRepository;
  GetCardDataUseCase(this.cardRepository);
  Future<CorporateCard> call({required UserApp userApp, required CorporateCard card}) async {
    return await cardRepository.getCardData(userApp: userApp, card: card);
  }
}
