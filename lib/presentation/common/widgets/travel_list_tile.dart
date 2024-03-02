import 'package:flutter/material.dart';

class TravelListTile extends StatelessWidget {
  const TravelListTile({
    super.key,
    required this.airline,
    required this.airport,
    required this.boardingPass,
    required this.dateTime,
  });
  final String dateTime;
  final String boardingPass;
  final String airline;
  final String airport;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          airport,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(dateTime),
        trailing: ElevatedButton(
          onPressed: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.card_travel,
              ),
              Text(boardingPass),
            ],
          ),
        ),
      ),
    );
  }
}
