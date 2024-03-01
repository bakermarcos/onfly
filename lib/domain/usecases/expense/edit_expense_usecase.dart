import 'package:onfly/data/repositories/repositories/expense_repository.dart';
import 'package:onfly/domain/entities/expense.dart';
import 'package:onfly/domain/entities/user_app.dart';

class EditExpenseUseCase {
  final ExpenseRepository expenseRepository;
  EditExpenseUseCase(this.expenseRepository);
  Future<Expense> call(
      {required UserApp userApp, required Expense expense}) async {
    return await expenseRepository.editExpense(
        userApp: userApp, expense: expense);
  }
}