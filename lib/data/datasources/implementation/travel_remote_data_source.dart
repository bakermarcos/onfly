import 'package:onfly/data/datasources/remote/travel_data_source.dart';
import 'package:onfly/domain/entities/travel.dart';

class RemoteTravelDataSource extends TravelDataSource {
  @override
  Future<Travel> getTravelData() {
    // TODO: implement getTravelData
    throw UnimplementedError();
  }

  @override
  Future<List<Travel>> getTravels() {
    // TODO: implement getTravels
    throw UnimplementedError();
  }

  @override
  Future<List<Travel>> updateTravels({required List<Travel> travels}) {
    // TODO: implement updateTravels
    throw UnimplementedError();
  }
}
