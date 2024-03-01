import 'package:onfly/data/repositories/repositories/travel_repository.dart';
import 'package:onfly/domain/entities/travel.dart';
import 'package:onfly/domain/entities/user_app.dart';

class UpdateTravelsUseCase {
  final TravelRepository travelRepository;
  UpdateTravelsUseCase(this.travelRepository);
  Future<List<Travel>> call(
      {required UserApp userApp, required List<Travel> travels}) async {
    return await travelRepository.updateTravels(
        userApp: userApp, travels: travels);
  }
}
