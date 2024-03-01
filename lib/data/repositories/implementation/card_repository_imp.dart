import 'package:onfly/data/datasources/remote/card_data_source.dart';
import 'package:onfly/data/repositories/repositories/card_repository.dart';
import 'package:onfly/domain/entities/corporate_card.dart';
import 'package:onfly/domain/entities/user_app.dart';

class CardRepositoryImp implements CardRepository {
  final CardDataSource cardDataSource;
  CardRepositoryImp(this.cardDataSource);
  @override
  Future<CorporateCard> getCardData({required UserApp userApp}) async {
    return await cardDataSource.getCardData(userApp: userApp);
  }

  @override
  Future<int> updateBalance(
      {required UserApp userApp, required int balance}) async {
    return await cardDataSource.updateBalance(
        userApp: userApp, balance: balance);
  }
}
