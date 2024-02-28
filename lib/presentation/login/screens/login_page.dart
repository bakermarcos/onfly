import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('Login'),
          TextFormField(
            controller: _userController,
          ),
          TextFormField(
            controller: _passwordController,
          ),
          ElevatedButton(onPressed: () {}, child: const Text('Login')),
        ],
      ),
    );
  }
}
