import 'package:onfly/domain/entities/corporate_card.dart';
import 'package:onfly/domain/entities/user_app.dart';

abstract class CardRepository {
  Future<CorporateCard> getCardData({
    required UserApp userApp,
  });

  Future<int> updateBalance({required UserApp userApp, required int balance});
}
