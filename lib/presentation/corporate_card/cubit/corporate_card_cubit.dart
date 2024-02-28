import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'corporate_card_state.dart';

class CorporateCardCubit extends Cubit<CorporateCardState> {
  CorporateCardCubit() : super(CorporateCardInitial());
}
