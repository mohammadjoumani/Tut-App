import 'dart:async';

import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';

import '../../../../domain/usecase/forget_password_usecarse.dart';
import '../../../base/base_viewmodel.dart';
import '../../../common/state_renderer/state_renderer.dart';

class ForgetPasswordViewModel extends BaseViewModel
    with ForgetPasswordViewModelInputs, ForgetPasswordViewModelOutputs {

  final StreamController _emailStreamController = StreamController<String>.broadcast();

  ForgetPasswordUseCase _forgetPasswordUseCase;
  ForgetPasswordViewModel(this._forgetPasswordUseCase);

  var email = "";
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
  }

  //region Inputs

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  void forgetPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _forgetPasswordUseCase.execute(
        ForgetPasswordUseCaseInput(email)))
        .fold(
            (failure) => {
          // left -> failure
          inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message))
        }, (data) {
          // right -> data (success)
          inputState.add(SuccessState(data.support));
        });
  }

  //endregion

  //region Outputs

  @override
  Stream<bool> get outIsEmailValid => _emailStreamController.stream.map((email) => _isEmailValid(email));

  //endregion

  //region Private fun

  _isEmailValid(String email) {
    return email.isNotEmpty;
  }
  //endregion
}

abstract class ForgetPasswordViewModelInputs {
  setEmail(String email);

  void forgetPassword();

  Sink get inputEmail;
}

abstract class ForgetPasswordViewModelOutputs {
  Stream<bool> get outIsEmailValid;
}
