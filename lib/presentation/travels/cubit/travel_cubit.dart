import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'travel_state.dart';

class TravelCubit extends Cubit<TravelState> {
  TravelCubit() : super(TravelInitial());
}
