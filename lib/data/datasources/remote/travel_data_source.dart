
import 'package:onfly/domain/entities/travel.dart';

abstract class TravelDataSource {
 Future<Travel> getTravelData();

 Future<List<Travel>> getTravels();

 Future<List<Travel>> updateTravels({required List<Travel> travels});
}