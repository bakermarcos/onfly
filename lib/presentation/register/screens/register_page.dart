import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _registerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _registerKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Nome'),
                TextFormField(
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Colors.grey),
                    labelText: 'Nome *',
                  ),
                  controller: _nameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Empresa'),
                TextFormField(
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Colors.grey),
                    labelText: 'Empresa *',
                  ),
                  controller: _companyController,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('E-mail'),
                TextFormField(
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Colors.grey),
                    labelText: 'E-mail *',
                  ),
                  controller: _userController,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Senha'),
                TextFormField(
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Colors.grey),
                    labelText: 'Senha *',
                  ),
                  controller: _passwordController,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {}, child: const Text('Registrar')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
