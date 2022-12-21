import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tut_app/domain/model/models.dart';

import '../../../../domain/usecase/login_usecarse.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginUseCase _loginUseCase;

  LoginBloc(this._loginUseCase) : super(LoginInitialState()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginSubmitEvent) {
        emit(LoginLoadingState());
        (await _loginUseCase.execute(LoginUseCaseInput(event.email, event.password)))
            .fold(
      (failure) {
      // left -> failure
        print("login failure state");
        emit(LoginFailureState());
      },
      (data) {
      // right -> data (success)
        print("Login success State");
        emit(LoginSuccessState(data));
      // isUserLoggedInSuccessfullyStreamController.add(true);
      });
      }
    });
  }
}
