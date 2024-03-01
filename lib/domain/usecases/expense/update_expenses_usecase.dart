import 'package:onfly/data/repositories/repositories/expense_repository.dart';
import 'package:onfly/domain/entities/expense.dart';
import 'package:onfly/domain/entities/user_app.dart';

class UpdateExpensesUseCase {
  final ExpenseRepository expenseRepository;
  UpdateExpensesUseCase(this.expenseRepository);
  Future<List<Expense>> call(
      {required UserApp userApp, required List<Expense> expenses}) async {
    return await expenseRepository.updateExpenses(
        userApp: userApp, expenses: expenses);
  }
}
