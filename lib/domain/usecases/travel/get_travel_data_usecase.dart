import 'package:onfly/data/repositories/repositories/travel_repository.dart';
import 'package:onfly/domain/entities/travel.dart';
import 'package:onfly/domain/entities/user_app.dart';

class GetTravelDataUseCase {
  final TravelRepository travelRepository;
  GetTravelDataUseCase(this.travelRepository);
  Future<Travel> call({required UserApp userApp, required Travel travel}) async{
    return await travelRepository.getTravelData(userApp: userApp, travel: travel);
  }
}
