import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onfly/presentation/expenses/cubit/expense_cubit.dart';

class ExpenseDetailsPage extends StatefulWidget {
  const ExpenseDetailsPage({super.key});

  @override
  State<ExpenseDetailsPage> createState() => _ExpenseDetailsPageState();
}

class _ExpenseDetailsPageState extends State<ExpenseDetailsPage> {
  late ExpenseCubit cubit = ExpenseCubit();
  @override
  void initState() {
    cubit.init();
    cubit.nameController.text = cubit.expense.name;
    cubit.dateController.text = cubit.expense.date;
    cubit.valueController.text = 'R\$ ${cubit.expense.value}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas'),
      ),
      body: BlocConsumer<ExpenseCubit, ExpenseState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is ExpenseErrorState) {
            Fluttertoast.showToast(msg: state.message);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
                child: ListView(
                    children: state is ExpenseEditingState
                        ? [
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
                                  await cubit.editExpense();
                                },
                                child: state is ExpenseLoadingState
                                    ? const CircularProgressIndicator()
                                    : const Text('Finalizar')),
                          ]
                        : [
                            Text(
                              cubit.nameController.text,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              cubit.dateController.text,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              cubit.valueController.text,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  cubit.isEditing();
                                },
                                child: const Text('Editar')),
                          ])),
          );
        },
      ),
    );
  }
}
