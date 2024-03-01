import 'package:onfly/data/repositories/repositories/travel_repository.dart';
import 'package:onfly/domain/entities/travel.dart';
import 'package:onfly/domain/entities/user_app.dart';

class GetTravelsUseCase {
  final TravelRepository travelRepository;
  GetTravelsUseCase(this.travelRepository);
  Future<List<Travel>> call({required UserApp userApp}) async {
    return await travelRepository.getTravels(userApp: userApp);
  }
}
