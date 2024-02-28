import 'package:flutter/material.dart';

class ExpenseDetailsPage extends StatefulWidget {
  const ExpenseDetailsPage({super.key});

  @override
  State<ExpenseDetailsPage> createState() => _ExpenseDetailsPageState();
}

class _ExpenseDetailsPageState extends State<ExpenseDetailsPage> {
  bool isEditing = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  @override
  void initState() {
    _nameController.text = 'Nome despesa';
    _dateController.text = 'Data';
    _valueController.text = 'R\$ Valor';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
            child: ListView(
                children: isEditing
                    ? [
                        TextFormField(
                          controller: _nameController,
                        ),
                        TextFormField(
                          controller: _dateController,
                        ),
                        TextFormField(
                          controller: _valueController,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isEditing = false;
                              });
                            },
                            child: const Text('Finalizar')),
                      ]
                    : [
                        Text(
                          _nameController.text,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          _dateController.text,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          _valueController.text,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isEditing = true;
                              });
                            },
                            child: const Text('Editar')),
                      ])),
      ),
    );
  }
}
