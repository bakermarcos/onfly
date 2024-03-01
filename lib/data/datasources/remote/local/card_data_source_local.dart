import 'package:onfly/domain/entities/corporate_card.dart';

abstract class CardDataSourceLocal {
  Future<CorporateCard> getCardData({
    required CorporateCard card,
  });

  Future<void> updateCardData({
    required CorporateCard card,
  });

  Future<int> updateBalance(
      {required CorporateCard card, required int balance, bool isSync = false});
}
