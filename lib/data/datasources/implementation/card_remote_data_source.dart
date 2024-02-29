import 'package:onfly/data/datasources/remote/card_data_source.dart';
import 'package:onfly/domain/entities/corporate_card.dart';

class RemoteCardDataSource implements CardDataSource {
  @override
  Future<CorporateCard> getCardData() async {
    //TODO: Implement this
    return CorporateCard(
      id: 0,
      cardNumber: 0,
      balance: 0,
      expenses: [],
    );
  }

  @override
  Future<int> updateBalance({required int balance}) async {
    //TODO: Implement this
    return 0;
  }
}
