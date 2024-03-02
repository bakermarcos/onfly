import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onfly/presentation/common/widgets/expense_list_tile.dart';
import 'package:onfly/presentation/corporate_card/screens/corporate_card_page.dart';
import 'package:onfly/presentation/home/cubit/home_cubit.dart';
import 'package:onfly/presentation/travels/screens/travels_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit cubit = HomeCubit();
  @override
  void initState() {
    cubit.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is HomeErrorState) {
          Fluttertoast.showToast(msg: state.message);
        }
      },
      builder: (context, state) {
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
                      onPressed: () {
                        showBottomSheet(
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.all(10),
                                child: ListView(
                                  children: [
                                    TextFormField(
                                      controller: cubit.nameController,
                                    ),
                                    TextFormField(
                                      controller: cubit.dateController,
                                    ),
                                    TextFormField(
                                      controller: cubit.valueController,
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          cubit.addExpense();
                                          await cubit.updateExpenses();
                                        },
                                        child: const Text('Adicionar')),
                                  ],
                                ),
                              );
                            });
                      },
                      icon: const Icon(
                        Icons.add_circle,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                state is HomeLoadedState
                    ? Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return ExpenseListTile(
                              name: state.expenses[index].name,
                              value: state.expenses[index].value,
                              date: state.expenses[index].date,
                            );
                          },
                          shrinkWrap: true,
                        ),
                      )
                    : state is HomeLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Center(child: Text('Ops, não há nada aqui')),
              ],
            ),
          ),
        );
      },
    );
  }
}
