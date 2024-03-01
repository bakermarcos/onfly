import 'package:hive/hive.dart';
import 'package:onfly/data/datasources/remote/local/card_data_source_local.dart';
import 'package:onfly/domain/entities/corporate_card.dart';

class RemoteCardDataSourceLocal implements CardDataSourceLocal {
  final Box<CorporateCard> cardBox = Hive.box<CorporateCard>('card_data');
  final Box<CorporateCard> syncCardBox =
      Hive.box<CorporateCard>('sync_card_data');
  @override
  Future<CorporateCard> getCardData({required CorporateCard card}) async {
    await cardBox.add(card);
    return card;
  }

  @override
  Future<int> updateBalance(
      {required CorporateCard card,
      required int balance,
      bool isSync = false}) async {
    CorporateCard? localCard = cardBox.get(card);
    if (localCard != null) {
      localCard.balance = balance;
      await cardBox.put(0, localCard);
      await syncCardBox.clear();
      if (isSync) {
        await syncCardBox.add(localCard);
      }
      return localCard.balance;
    }
    return balance;
  }

  @override
  Future<void> updateCardData({required CorporateCard card}) async {
    await cardBox.put(card.id, card);
  }
}
