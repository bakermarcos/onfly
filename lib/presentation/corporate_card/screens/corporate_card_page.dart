import 'package:flutter/material.dart';
import 'package:onfly/presentation/common/widgets/expense_list_tile.dart';

class CorporateCard extends StatefulWidget {
  const CorporateCard({super.key});

  @override
  State<CorporateCard> createState() => _CorporateCardState();
}

class _CorporateCardState extends State<CorporateCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cartão corporativo'),
      ),
      body: Column(
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
          ))
        ],
      ),
    );
  }
}
