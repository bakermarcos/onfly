import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onfly/presentation/common/widgets/expense_list_tile.dart';
import 'package:onfly/presentation/corporate_card/cubit/corporate_card_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CorporateCardPage extends StatefulWidget {
  const CorporateCardPage({super.key});

  @override
  State<CorporateCardPage> createState() => _CorporateCardPageState();
}

class _CorporateCardPageState extends State<CorporateCardPage> {
  late CorporateCardCubit cubit = CorporateCardCubit();
  @override
  void initState() {
    cubit.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cartão corporativo'),
      ),
      body: BlocConsumer<CorporateCardCubit, CorporateCardState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is ErrorCorporateCardState) {
            Fluttertoast.showToast(msg: state.message);
          }
        },
        builder: (context, state) {
          if (state is InitialCorporateCardState) {
            cubit.init();
          } else if (state is LoadingCorporateCardState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedCorporateCardState) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Saldo',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text('R\$ ${state.card.balance.toString()}'),
                  const Text(
                    'Extrato',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: ListView.builder(itemBuilder: (context, index) {
                    return ExpenseListTile(
                      name: state.expenses[index].name,
                      value: state.expenses[index].value.toString(),
                      date: state.expenses[index].date,
                    );
                  })),
                ],
              ),
            );
          }
          return const Center(
            child: Text(
                'Ops! Aconteceu algo inesperado, volte para atualizar novamente'),
          );
        },
      ),
    );
  }
}
