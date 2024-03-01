import 'package:onfly/data/datasources/remote/travel_data_source.dart';
import 'package:onfly/data/repositories/repositories/travel_repository.dart';
import 'package:onfly/domain/entities/travel.dart';
import 'package:onfly/domain/entities/user_app.dart';

class TravelRepositoryImp implements TravelRepository {
  final TravelDataSource travelDataSource;
  TravelRepositoryImp(this.travelDataSource);
  @override
  Future<Travel> getTravelData(
      {required UserApp userApp, required Travel travel}) async {
    return await travelDataSource.getTravelData(
        userApp: userApp, travel: travel);
  }

  @override
  Future<List<Travel>> getTravels({required UserApp userApp}) async {
    return await travelDataSource.getTravels(userApp: userApp);
  }

  @override
  Future<List<Travel>> updateTravels(
      {required UserApp userApp, required List<Travel> travels}) async {
    return await travelDataSource.updateTravels(
        userApp: userApp, travels: travels);
  }
}
