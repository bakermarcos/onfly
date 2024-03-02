part of 'corporate_card_cubit.dart';

@immutable
sealed class CorporateCardState {}

final class InitialCorporateCardState extends CorporateCardState {}

final class LoadingCorporateCardState extends CorporateCardState {}

final class LoadedCorporateCardState extends CorporateCardState {
  final CorporateCard card;
  final List<Expense> expenses;
  LoadedCorporateCardState(this.card, this.expenses);
}

final class ErrorCorporateCardState extends CorporateCardState {
  final String message;
  ErrorCorporateCardState(this.message);
}
