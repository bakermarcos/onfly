import 'package:onfly/domain/entities/travel.dart';
import 'package:onfly/domain/entities/user_app.dart';

abstract class TravelRepository {
  Future<Travel> getTravelData(
      {required UserApp userApp, required Travel travel});

  Future<List<Travel>> getTravels({required UserApp userApp});

  Future<List<Travel>> updateTravels(
      {required UserApp userApp, required List<Travel> travels});
}
