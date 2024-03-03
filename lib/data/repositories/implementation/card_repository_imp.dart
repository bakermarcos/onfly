import 'package:onfly/data/datasources/remote/api/card_data_source_api.dart';
import 'package:onfly/data/datasources/remote/local/card_data_source_local.dart';
import 'package:onfly/data/repositories/repositories/card_repository.dart';
import 'package:onfly/domain/entities/corporate_card.dart';
import 'package:onfly/domain/entities/user_app.dart';

class CardRepositoryImp implements CardRepository {
  final CardDataSourceApi cardDataSourceApi;
  final CardDataSourceLocal cardDataSourceLocal;
  CardRepositoryImp(this.cardDataSourceApi, this.cardDataSourceLocal);
  @override
  Future<CorporateCard> getCardData(
      {required UserApp userApp, required CorporateCard card}) async {
    CorporateCard response;
    try {
      response = await cardDataSourceApi.getCardData(userApp: userApp);
      await cardDataSourceLocal.updateCardData(card: response);
    } catch (e) {
      response = await cardDataSourceLocal.getCardData(card: card);
      rethrow;
    }
    return response;
  }

  @override
  Future<double> updateBalance(
      {required UserApp userApp,
      required double balance,
      required CorporateCard card}) async {
    double response;
    try {
      response = await cardDataSourceApi.updateBalance(
          userApp: userApp, balance: balance);
      await cardDataSourceLocal.updateBalance(balance: response, card: card);
    } catch (e) {
      response = await cardDataSourceLocal.updateBalance(
          balance: balance, isSync: true, card: card);
      rethrow;
    }
    return response;
  }
}
