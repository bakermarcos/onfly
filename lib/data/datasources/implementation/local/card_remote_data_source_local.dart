import 'package:hive/hive.dart';
import 'package:onfly/data/datasources/remote/local/card_data_source_local.dart';
import 'package:onfly/domain/entities/corporate_card.dart';

class RemoteCardDataSourceLocal implements CardDataSourceLocal {
  RemoteCardDataSourceLocal(this.cardBox, this.syncCardBox);
  final Box<CorporateCard> cardBox; 
  final Box<CorporateCard> syncCardBox;
  @override
  Future<CorporateCard> getCardData({required CorporateCard card}) async {
    await cardBox.add(card);
    return card;
  }

  @override
  Future<double> updateBalance(
      {required CorporateCard card,
      required double balance,
      bool isSync = false}) async {
    CorporateCard? localCard = cardBox.get(card);
    if (localCard != null) {
      localCard.balance = balance;
      await cardBox.put(0, localCard);
      if (isSync) {
        await syncCardBox.add(localCard);
      }else{
        await syncCardBox.clear();
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
