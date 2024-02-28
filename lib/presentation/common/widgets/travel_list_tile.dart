import 'package:flutter/material.dart';

class TravelListTile extends StatelessWidget {
  const TravelListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Lugar da viagem'),
      leading: Text(DateTime.now().toIso8601String()),
      trailing: ElevatedButton(
        onPressed: () {},
        child: const Column(
          children: [
            Icon(Icons.card_travel),
            Text('Cartão de embarque'),
          ],
        ),
      ),
    );
  }
}
