import 'package:onfly/domain/entities/corporate_card.dart';
import 'package:onfly/domain/entities/user_app.dart';

abstract class CardDataSourceApi {
  Future<CorporateCard> getCardData({
    required UserApp userApp,
  });

  Future<double> updateBalance({required UserApp userApp, required double balance});
}
