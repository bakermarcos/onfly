import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onfly/presentation/home/screens/home_page.dart';
import 'package:onfly/presentation/login/cubit/login_cubit.dart';
import 'package:onfly/presentation/register/screens/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginCubit cubit = LoginCubit();

  @override
  void initState() {
    cubit.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is LoginLoadUserState) {
            cubit.loadUserData();
          }
          if (state is LoginErrorState) {
            Fluttertoast.showToast(msg: state.message);
          }
          if (state is LoginLoadedState) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          }
          if (state is LoginGoToRegisterPageState) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const RegisterPage(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Colors.grey),
                    labelText: 'E-mail',
                  ),
                  controller: cubit.loginController,
                ),
                TextFormField(
                  obscureText: cubit.obscureText,
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.grey),
                    labelText: 'Senha',
                    suffixIcon: IconButton(
                        onPressed: () {
                          cubit.changeObscureText();
                        },
                        icon: Icon(
                          cubit.obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        )),
                  ),
                  controller: cubit.passwordController,
                ),
                const SizedBox(
                  height: 10,
                ),
                state is LoginLoadingState
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () => cubit.login(),
                        child: const Text('Login'),
                      ),
                // TODO: Implementar página de cadastro
                // const SizedBox(
                //   height: 10,
                // ),
                // TextButton(
                //   onPressed: () => cubit.goToRegisterPage(),
                //   child: const Text('Cadastrar'),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
