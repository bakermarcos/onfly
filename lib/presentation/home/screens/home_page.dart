import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onfly/presentation/common/services/logout.dart';
import 'package:onfly/presentation/common/sync_cubit/sync_cubit.dart';
import 'package:onfly/presentation/common/widgets/expense_list_tile.dart';
import 'package:onfly/presentation/corporate_card/screens/corporate_card_page.dart';
import 'package:onfly/presentation/home/cubit/home_cubit.dart';
import 'package:onfly/presentation/login/screens/login_page.dart';
import 'package:onfly/presentation/report/screens/report_chart_page.dart';
import 'package:onfly/presentation/travels/screens/travels_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeCubit cubit = HomeCubit();
  @override
  void initState() {
    cubit.init();
    cubit.syncCubit.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem vindo, Usuário'),
        actions: [
          BlocConsumer<SyncCubit, SyncState>(
            bloc: cubit.syncCubit,
            listener: (context, state) {
              if (state is SyncErrorState) {
                Fluttertoast.showToast(msg: state.message);
              }
            },
            builder: (context, state) {
              return IconButton(
                  onPressed: () async => state is SyncLoadingState
                      ? null
                      : await cubit.syncCubit.update(),
                  icon: state is SyncLoadingState
                      ? const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        )
                      : const Icon(Icons.sync, color: Colors.deepPurple));
            },
          ),
          IconButton(
              onPressed: () async {
                if (await cubit.syncCubit.checkPendingUpdates()) {
                  Fluttertoast.showToast(
                      msg: 'Você ainda tem updates pendentes.');
                } else {
                  LogoutService.logout()
                      .then((value) => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          ));
                }
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        bloc: cubit,
        listener: (context, state) {
          cubit.syncCubit.checkPendingUpdates();
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
                    const SizedBox(
                      width: 15,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ReportChartPage(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.bar_chart_rounded,
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
                      : Flexible(
                          child: ListView.builder(
                            reverse: true,
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
