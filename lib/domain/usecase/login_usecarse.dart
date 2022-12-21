import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/domain/usecase/base_usercase.dart';

import '../repository/repository.dart';

class LoginUseCase extends BaseUseCase<LoginUseCaseInput, Authentication> {

  final Repository _repository;

  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(input) async {
    return await _repository.login(LoginRequest(input.email, input.password));
  }

}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}