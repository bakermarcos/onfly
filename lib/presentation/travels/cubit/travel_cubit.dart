import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:onfly/data/datasources/implementation/api/travel_remote_data_source_api.dart';
import 'package:onfly/data/datasources/implementation/local/travel_remote_data_source_local.dart';
import 'package:onfly/data/datasources/remote/api/travel_data_source_api.dart';
import 'package:onfly/data/datasources/remote/local/travel_data_source_local.dart';
import 'package:onfly/data/repositories/implementation/travel_repository_imp.dart';
import 'package:onfly/data/repositories/repositories/travel_repository.dart';
import 'package:onfly/domain/entities/travel.dart';
import 'package:onfly/domain/entities/user_app.dart';
import 'package:onfly/domain/usecases/travel/get_travel_data_usecase.dart';
import 'package:onfly/domain/usecases/travel/get_travels_usecase.dart';

part 'travel_state.dart';

class TravelCubit extends Cubit<TravelState> {
  final TravelDataSourceApi _travelDataSourceApi =
      RemoteTravelDataSourceApi(FirebaseDatabase.instance);
  final TravelDataSourceLocal _travelDataSourceLocal =
      RemoteTravelDataSourceLocal();
  late final TravelRepository _travelRepository;
  late final GetTravelDataUseCase _getTravelDataUseCase;
  late final GetTravelsUseCase _getTravelsUseCase;
  late UserApp _userApp;
  UserApp get userApp => _userApp;
  late List<Travel> _travels;
  late Travel _travel;
  List<Travel> get travels => _travels;
  Travel get travel => _travel;
  TravelCubit() : super(TravelInitialState());

  void init() async {
    _travelRepository =
        TravelRepositoryImp(_travelDataSourceApi, _travelDataSourceLocal);
    _getTravelDataUseCase = GetTravelDataUseCase(_travelRepository);
    _getTravelsUseCase = GetTravelsUseCase(_travelRepository);
    _userApp = Hive.box<UserApp>('user_data').values.first;
    _travels = Hive.box<Travel>('travels').values.toList();
    await getTravels();
  }

  Future<void> getTravelData(Travel travel) async {
    emit(TravelLoadingState());
    try {
      _travel =
          await _getTravelDataUseCase.call(userApp: _userApp, travel: travel);
    } catch (e) {
      emit(TravelErrorState(e.toString()));
    }
    emit(TravelLoadedState(_travels));
  }

  Future<void> getTravels() async {
    emit(TravelLoadingState());
    try {
      _travels = await _getTravelsUseCase.call(userApp: _userApp);
    } catch (e) {
      emit(TravelErrorState(e.toString()));
    }
    emit(TravelLoadedState(_travels));
  }
}
