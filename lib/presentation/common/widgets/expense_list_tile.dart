import 'package:flutter/material.dart';
import 'package:onfly/presentation/expenses/screens/expense_details_page.dart';

class ExpenseListTile extends StatelessWidget {
  const ExpenseListTile(
      {super.key, required this.name, required this.date, required this.value});
  final String name;
  final String value;
  final String date;

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
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('R\$ $value'),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(date),
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
