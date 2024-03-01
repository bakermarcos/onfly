import 'package:onfly/data/repositories/repositories/expense_repository.dart';
import 'package:onfly/domain/entities/expense.dart';
import 'package:onfly/domain/entities/user_app.dart';

class GetExpensesUseCase {
  final ExpenseRepository expenseRepository;
  GetExpensesUseCase(this.expenseRepository);
  Future<List<Expense>> call({required UserApp userApp}) async {
    return await expenseRepository.getExpenses(userApp: userApp);
  }
}
