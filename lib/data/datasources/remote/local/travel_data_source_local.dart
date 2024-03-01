import 'package:onfly/domain/entities/travel.dart';

abstract class TravelDataSourceLocal {
  Future<Travel> getTravelData({required Travel travel});

  Future<void> updateTravelData({required Travel travel});

  Future<List<Travel>> getTravels();

  Future<List<Travel>> updateTravels(
      {required List<Travel> travels, bool isSync = false});
}
