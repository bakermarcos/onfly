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
  CorporateCardCubit cubit = CorporateCardCubit();
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
          if (state is LoadingCorporateCardState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LoadedCorporateCardState) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        state.card.cardFlag,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '**** ${state.card.cardNumber.toString().substring(12)}',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Saldo',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'R\$ ${cubit.balanceFormatted()}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Extrato',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                  Flexible(
                      child: ListView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          itemCount: state.expenses.length,
                          itemBuilder: (context, index) {
                            return ExpenseListTile(
                                expense: state.expenses[index]);
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
