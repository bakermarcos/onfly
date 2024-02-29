import 'package:flutter/material.dart';
import 'package:onfly/presentation/expenses/screens/expense_details_page.dart';

class ExpenseListTile extends StatelessWidget {
  const ExpenseListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ExpenseDetailsPage(),
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Nome despesa',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('R\$ Valor'),
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Data'),
            Flexible(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ExpenseDetailsPage(),
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
