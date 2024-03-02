import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onfly/presentation/common/widgets/travel_list_tile.dart';
import 'package:onfly/presentation/travels/cubit/travel_cubit.dart';

class TravelsPage extends StatefulWidget {
  const TravelsPage({super.key});

  @override
  State<TravelsPage> createState() => _TravelsPageState();
}

class _TravelsPageState extends State<TravelsPage> {
  final TravelCubit cubit = TravelCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Viagens'),
      ),
      body: BlocConsumer<TravelCubit, TravelState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is TravelErrorState) {
            Fluttertoast.showToast(msg: state.message);
          }
        },
        builder: (context, state) {
          if (state is TravelLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: cubit.travels.length,
            itemBuilder: (context, index) {
              return TravelListTile(
                boardingPass: cubit.travels[index].boardingPass,
                airline: cubit.travels[index].airline,
                airport: cubit.travels[index].airport,
                dateTime: cubit.travels[index].date,
              );
            },
          );
        },
      ),
    );
  }
}
