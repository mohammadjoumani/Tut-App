import 'dart:async';

import 'package:tut_app/domain/usecase/login_usecarse.dart';
import 'package:tut_app/presentation/base/base_viewmodel.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';

import '../../../common/freezed_data_classes.dart';
import '../../../common/state_renderer/state_renderer.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final StreamController _inputAreAllValidateStreamController = StreamController<void>.broadcast();
  final StreamController isUserLoggedInSuccessfullyStreamController = StreamController<bool>();

  // var isUSerValidait = Mutable<Boolean>(false)
  //isUserValidate.value = false;
  //val a = isUserValidate.value
  var loginObject = LoginObject("", "");
  LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  // LoginViewModel();

  @override
  void dispose() {
    super.dispose();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _inputAreAllValidateStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  //region Inputs

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputAreAllValidate.add(null);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    inputAreAllValidate.add(null);
  }

  @override
  void login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold(
            (failure) => {
                  // left -> failure
                  inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message))
                },
            (data) {
                  // right -> data (success)
              inputState.add(ContentState());
                  isUserLoggedInSuccessfullyStreamController.add(true);
                });
  }

  @override
  Sink get inputAreAllValidate => _inputAreAllValidateStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  //endregion

  //region Outputs

  @override
  Stream<bool> get outAreAllInputsValid =>
      _inputAreAllValidateStreamController.stream.map((_) => _areAllValidate());

  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValidate(password));

  @override
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValidate(userName));

  //endregion

  //region Private fun

  bool _isUserNameValidate(String userName) {
    return userName.isNotEmpty;
  }

  bool _isPasswordValidate(String password) {
    return password.isNotEmpty;
  }

  bool _areAllValidate() {
    return _isUserNameValidate(loginObject.userName) &&
        _isPasswordValidate(loginObject.password);
  }

//endregion
}

abstract class LoginViewModelInputs {
  setUserName(String userName);

  setPassword(String password);

  void login();

  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputAreAllValidate;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsUserNameValid;

  Stream<bool> get outIsPasswordValid;

  Stream<bool> get outAreAllInputsValid;
}
