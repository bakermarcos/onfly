import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onfly/domain/entities/expense.dart';
import 'package:onfly/presentation/expenses/screens/expense_details_page.dart';

class ExpenseListTile extends StatelessWidget {
  const ExpenseListTile({super.key, required this.expense});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ExpenseDetailsPage(expense: expense),
          ),
        ),
        leading: Text(expense.category),
        title: Text(
          expense.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('R\$ ${expense.value}'),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(expense.date),
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ExpenseDetailsPage(expense: expense),
                    ),
                  );
                },
                child: const Text('Editar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
