import 'package:hive/hive.dart';
import 'package:onfly/data/datasources/remote/local/travel_data_source_local.dart';
import 'package:onfly/domain/entities/travel.dart';

class RemoteTravelDataSourceLocal extends TravelDataSourceLocal {
  RemoteTravelDataSourceLocal(this.travelBox, this.syncTravelBox);
  final Box<Travel> travelBox;
  final Box<Travel> syncTravelBox;
  @override
  Future<Travel> getTravelData({required Travel travel}) async {
    return travelBox.get(travel) ?? travel;
  }

  @override
  Future<List<Travel>> getTravels() async {
    return travelBox.values.toList();
  }

  @override
  Future<List<Travel>> updateTravels(
      {required List<Travel> travels, bool isSync = false}) async {
    if (isSync) {
      await syncTravelBox.addAll(travels);
    } else {
      await syncTravelBox.clear();
    }
    await travelBox.clear();
    await travelBox.addAll(travels);

    return travels;
  }

  @override
  Future<void> updateTravelData({required Travel travel}) async {
    await travelBox.put(travel.id, travel);
  }
}
