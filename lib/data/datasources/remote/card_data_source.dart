import 'package:onfly/domain/entities/corporate_card.dart';

abstract class CardDataSource {
 Future<CorporateCard> getCardData();

 Future<int> updateBalance({required int balance});
}