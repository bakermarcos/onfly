import 'package:onfly/data/datasources/remote/api/travel_data_source_api.dart';
import 'package:onfly/data/datasources/remote/local/travel_data_source_local.dart';
import 'package:onfly/data/repositories/repositories/travel_repository.dart';
import 'package:onfly/domain/entities/travel.dart';
import 'package:onfly/domain/entities/user_app.dart';

class TravelRepositoryImp implements TravelRepository {
  final TravelDataSourceApi travelDataSourceApi;
  final TravelDataSourceLocal travelDataSourceLocal;
  TravelRepositoryImp(this.travelDataSourceApi, this.travelDataSourceLocal);
  @override
  Future<Travel> getTravelData(
      {required UserApp userApp, required Travel travel}) async {
    Travel response;
    try {
      response = await travelDataSourceApi.getTravelData(
          userApp: userApp, travel: travel);
      await travelDataSourceLocal.updateTravelData(travel: response);
    } catch (e) {
      response = await travelDataSourceLocal.getTravelData(travel: travel);
      rethrow;
    }
    return response;
  }

  @override
  Future<List<Travel>> getTravels({required UserApp userApp}) async {
    List<Travel> response;
    try {
      response = await travelDataSourceApi.getTravels(userApp: userApp);
      await travelDataSourceLocal.updateTravels(travels: response);
    } catch (e) {
      response = await travelDataSourceLocal.getTravels();
      rethrow;
    }
    return response;
  }

  @override
  Future<List<Travel>> updateTravels(
      {required UserApp userApp, required List<Travel> travels}) async {
    List<Travel> response;
    try {
      response = await travelDataSourceApi.updateTravels(
          userApp: userApp, travels: travels);
      await travelDataSourceLocal.updateTravels(travels: response);
    } catch (e) {
      response = await travelDataSourceLocal.updateTravels(
          travels: travels, isSync: true);
      rethrow;
    }
    return response;
  }
}
