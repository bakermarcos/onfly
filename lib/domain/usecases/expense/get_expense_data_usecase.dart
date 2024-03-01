import 'package:onfly/data/repositories/repositories/expense_repository.dart';
import 'package:onfly/domain/entities/expense.dart';
import 'package:onfly/domain/entities/user_app.dart';

class GetExpenseDataUseCase {
  final ExpenseRepository expenseRepository;
  GetExpenseDataUseCase(this.expenseRepository);
  Future<Expense> call(
      {required UserApp userApp, required Expense expense}) async {
    return await expenseRepository.getExpenseData(
        userApp: userApp, expense: expense);
  }
}
