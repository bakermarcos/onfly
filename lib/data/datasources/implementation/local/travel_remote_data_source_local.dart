import 'package:hive/hive.dart';
import 'package:onfly/data/datasources/remote/local/travel_data_source_local.dart';
import 'package:onfly/domain/entities/travel.dart';

class RemoteTravelDataSourceLocal extends TravelDataSourceLocal {
  final Box<Travel> travelBox = Hive.box<Travel>('travels');
  final Box<Travel> syncTravelBox = Hive.box<Travel>('sync_travels');
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
    await syncTravelBox.clear();
    if (isSync) {
      await syncTravelBox.addAll(travels);
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
