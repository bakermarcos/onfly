import 'package:flutter/material.dart';

class TravelListTile extends StatelessWidget {
  const TravelListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Lugar da viagem',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(DateTime.now().toIso8601String()),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {},
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.card_travel,
              ),
              Text('Cartão de embarque'),
            ],
          ),
        ),
      ),
    );
  }
}
