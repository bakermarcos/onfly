import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:onfly/data/datasources/remote/api/card_data_source_api.dart';
import 'package:onfly/domain/entities/corporate_card.dart';
import 'package:onfly/domain/entities/user_app.dart';

class RemoteCardDataSourceApi implements CardDataSourceApi {
  final FirebaseDatabase _firebaseDatabase;
  RemoteCardDataSourceApi(this._firebaseDatabase);
  @override
  Future<CorporateCard> getCardData({
    required UserApp userApp,
  }) async {
    CorporateCard card;
    final DatabaseReference ref = _firebaseDatabase.ref('${userApp.id}/card');

    try {
      final cardDataSnapshot = await ref.get();
      card = CorporateCard.fromJson(jsonEncode(cardDataSnapshot.value));
      return card;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<double> updateBalance(
      {required UserApp userApp, required double balance}) async {
    final DatabaseReference ref =
        _firebaseDatabase.ref('${userApp.id}/card/balance');

    try {
      await ref.set(balance);
      return balance;
    } catch (e) {
      rethrow;
    }
  }
}
