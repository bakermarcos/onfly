import 'package:flutter/material.dart';
import 'package:onfly/presentation/common/widgets/expense_list_tile.dart';

class CorporateCardPage extends StatefulWidget {
  const CorporateCardPage({super.key});

  @override
  State<CorporateCardPage> createState() => _CorporateCardPageState();
}

class _CorporateCardPageState extends State<CorporateCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cartão corporativo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Saldo',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text('R\$ 2000,00'),
            const Text(
              'Extrato',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView(
                children: const [
                  ExpenseListTile(),
                  ExpenseListTile(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
