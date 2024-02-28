import 'package:flutter/material.dart';
import 'package:onfly/presentation/common/widgets/expense_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem vindo, Usuário'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.credit_card),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.travel_explore),
              ),
            ],
          ),
          Row(
            children: [
              const Text('Despesas'),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: const [
                ExpenseListTile(),
                ExpenseListTile(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
