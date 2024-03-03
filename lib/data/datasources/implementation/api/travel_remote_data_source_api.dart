import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:onfly/data/datasources/remote/api/travel_data_source_api.dart';
import 'package:onfly/domain/entities/travel.dart';
import 'package:onfly/domain/entities/user_app.dart';

class RemoteTravelDataSourceApi implements TravelDataSourceApi {
  final FirebaseDatabase _firebaseDatabase;
  RemoteTravelDataSourceApi(this._firebaseDatabase);
  @override
  Future<Travel> getTravelData(
      {required UserApp userApp, required Travel travel}) async {
    final DatabaseReference ref =
        _firebaseDatabase.ref('${userApp.id}/travels/${travel.id}');

    try {
      final travelDataSnapshot = await ref.get();
      travel = Travel.fromJson(jsonDecode(travelDataSnapshot.value as String));
      return travel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Travel>> getTravels({required UserApp userApp}) async {
    List<Travel> travels = [];
    final DatabaseReference ref =
        _firebaseDatabase.ref('${userApp.id}/travels');

    try {
      final travelsSnapshot = await ref.get();
      for (var travel in travelsSnapshot.value as List) {
        travels.add(Travel.fromJson(jsonEncode(travel)));
      }
      return travels;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Travel>> updateTravels(
      {required UserApp userApp, required List<Travel> travels}) async {
    final DatabaseReference ref =
        _firebaseDatabase.ref('${userApp.id}/travels');
    try {
      final travelsSnapshot = await ref.get();
      if (travels == travelsSnapshot.value as List ||
          travels.length > (travelsSnapshot.value as List).length) {
        await ref.set(travels);
      } else {
        travels = await getTravels(userApp: userApp);
      }
      return travels;
    } catch (e) {
      rethrow;
    }
  }
}
