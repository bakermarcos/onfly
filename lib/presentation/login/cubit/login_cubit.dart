import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:onfly/data/datasources/implementation/api/user_remote_data_source_api.dart';
import 'package:onfly/data/datasources/remote/api/user_data_source_api.dart';
import 'package:onfly/data/repositories/implementation/user_repository_imp.dart';
import 'package:onfly/data/repositories/repositories/user_repository.dart';
import 'package:onfly/domain/entities/user_app.dart';
import 'package:onfly/domain/usecases/user/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserDataSourceApi _userDataSourceApi =
      RemoteUserDataSourceApi(FirebaseAuth.instance);
  late final UserRepository _userRepository;
  late final LoginUseCase _loginUseCase;
  UserApp _userApp = UserApp.empty();
  UserApp get userApp => _userApp;
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  LoginCubit() : super(LoginInitialState());

  void init() async {
    _userRepository = UserRepositoryImpl(_userDataSourceApi);
    _loginUseCase = LoginUseCase(_userRepository);
  }

  Future<void> loadUserData() async {
    emit(LoginLoadingState());
    await Hive.box<UserApp>('user_data').add(_userApp);
    emit(LoginLoadedState(_userApp));
  }

  void goToRegisterPage() {
    emit(LoginGoToRegisterPageState());
  }

  void changeObscureText() {
    obscureText = !obscureText;
    emit(LoginInitialState());
  }

  Future<void> login() async {
    emit(LoginLoadingState());
    try {
      _userApp = await _loginUseCase.call(
          email: loginController.text, password: passwordController.text);
      emit(LoginLoadUserState());
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }
}
