import 'package:onfly/domain/entities/corporate_card.dart';
import 'package:onfly/domain/entities/user_app.dart';

abstract class CardRepository {
  Future<CorporateCard> getCardData(
      {required UserApp userApp, required CorporateCard card});

  Future<double> updateBalance(
      {required UserApp userApp,
      required double balance,
      required CorporateCard card});
}
