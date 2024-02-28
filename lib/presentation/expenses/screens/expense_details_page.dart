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
      body: Center(
          child: ListView(
        children: isEditing
            ? [
                Text(_nameController.text),
                Text(_dateController.text),
                Text(_valueController.text),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isEditing = true;
                      });
                    },
                    child: const Text('Editar')),
              ]
            : [
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
              ],
      )),
    );
  }
}
