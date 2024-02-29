import 'package:flutter/material.dart';
import 'package:onfly/presentation/common/widgets/travel_list_tile.dart';

class TravelsPage extends StatefulWidget {
  const TravelsPage({super.key});

  @override
  State<TravelsPage> createState() => _TravelsPageState();
}

class _TravelsPageState extends State<TravelsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Viagens'),
      ),
      body: ListView(
        children: const [
          TravelListTile(),
          TravelListTile(),
          TravelListTile(),
        ],
      ),
    );
  }
}
