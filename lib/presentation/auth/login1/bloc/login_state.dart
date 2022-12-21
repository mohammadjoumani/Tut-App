part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginFailureState extends LoginState {}

class LoginSuccessState extends LoginState {
  final Authentication _authentication;

  LoginSuccessState(this._authentication);
}
