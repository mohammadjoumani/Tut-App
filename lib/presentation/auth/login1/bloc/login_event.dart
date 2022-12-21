part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginSubmitEvent extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitEvent({required this.email, required this.password});
}
