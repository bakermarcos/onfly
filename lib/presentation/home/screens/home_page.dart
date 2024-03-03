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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem vindo, Usuário'),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is HomeErrorState) {
            Fluttertoast.showToast(msg: state.message);
          }
          if (state is HomePopBottomSheetState) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return Padding(
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
                                      decoration: const InputDecoration(
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                        labelText: 'Descrição despesa',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: cubit.dateController,
                                      decoration: const InputDecoration(
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                        labelText: 'Data',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: cubit.valueController,
                                      decoration: const InputDecoration(
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                        labelText: 'Valor',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: cubit.categoryController,
                                      decoration: const InputDecoration(
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                        labelText: 'Categoria',
                                      ),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          cubit.addExpense();
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
                if (state is HomeLoadedState)
                  state.expenses.isEmpty
                      ? const Center(
                          child: Text('Ainda não há nada por aqui'),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: state.expenses.length,
                            itemBuilder: (context, index) {
                              return ExpenseListTile(
                                  expense: state.expenses[index]);
                            },
                            shrinkWrap: true,
                          ),
                        )
                else
                  state is HomeLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const Center(child: Text('Ops, não há nada aqui')),
              ],
            ),
          );
        },
      ),
    );
  }
}
