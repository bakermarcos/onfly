import 'package:flutter/material.dart';
import 'package:onfly/presentation/expenses/screens/expense_details_page.dart';

class ExpenseListTile extends StatelessWidget {
  const ExpenseListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(DateTime.now().toIso8601String()),
      leading: const Column(
        children: [
          Text('Nome despesa'),
          Text('R\$ Valor'),
        ],
      ),
      trailing: Column(
        children: [
          const Text('Data'),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ExpenseDetailsPage(),
                ),
              );
            },
            child: const Text('Editar'),
          ),
        ],
      ),
    );
  }
}
