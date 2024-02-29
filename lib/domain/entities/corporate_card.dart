import 'package:onfly/domain/entities/expense.dart';

class CorporateCard {
  final int id;
  final int cardNumber;
  final int balance;
  final List<Expense> expenses;

  CorporateCard({
    required this.id,
    required this.cardNumber,
    required this.balance,
    required this.expenses,
  });
}
