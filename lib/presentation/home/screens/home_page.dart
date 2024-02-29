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
        title: const Text('Bem vindo, Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CorporateCardPage(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.credit_card,
                    size: 50,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TravelsPage(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.travel_explore,
                    size: 50,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Despesas',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_circle, size: 30,),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
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
