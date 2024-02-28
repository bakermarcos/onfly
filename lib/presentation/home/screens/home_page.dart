import 'package:flutter/material.dart';
import 'package:onfly/presentation/common/widgets/expense_list_tile.dart';
import 'package:onfly/presentation/corporate_card/screens/corporate_card_page.dart';
import 'package:onfly/presentation/travels/screens/travels_page.dart';

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
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CorporateCard(),
                    ),
                  );
                },
                icon: const Icon(Icons.credit_card),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TravelsPage(),
                    ),
                  );
                },
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
