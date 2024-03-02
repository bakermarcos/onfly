part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitialState extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginLoadUserState extends LoginState {}

final class LoginGoToRegisterPageState extends LoginState {}

final class LoginLoadedState extends LoginState {
  final UserApp user;
  LoginLoadedState(this.user);
}

final class LoginErrorState extends LoginState {
  final String message;
  LoginErrorState(this.message);
}
