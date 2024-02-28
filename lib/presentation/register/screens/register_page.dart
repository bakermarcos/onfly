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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
            ),
            TextFormField(
              controller: _companyController,
            ),
            TextFormField(
              controller: _userController,
            ),
            TextFormField(
              controller: _passwordController,
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Registrar')),
          ],
        ),
      ),
    );
  }
}
