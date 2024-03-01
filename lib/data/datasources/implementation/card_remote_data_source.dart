import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:onfly/data/datasources/remote/card_data_source.dart';
import 'package:onfly/domain/entities/corporate_card.dart';
import 'package:onfly/domain/entities/user_app.dart';

class RemoteCardDataSource implements CardDataSource {
  @override
  Future<CorporateCard> getCardData({
    required UserApp userApp,
  }) async {
    CorporateCard card;
    final DatabaseReference ref =
        FirebaseDatabase.instance.ref('${userApp.id}/card');

    try {
      final cardDataSnapshot = await ref.get();
      card =
          CorporateCard.fromJson(jsonDecode(cardDataSnapshot.value as String));
      return card;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> updateBalance(
      {required UserApp userApp, required int balance}) async {
    final DatabaseReference ref =
        FirebaseDatabase.instance.ref('${userApp.id}/card/balance');

    try {
      await ref.set(balance);
      return balance;
    } catch (e) {
      rethrow;
    }
  }
}
