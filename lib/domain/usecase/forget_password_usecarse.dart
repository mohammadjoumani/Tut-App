import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/domain/usecase/base_usercase.dart';

import '../repository/repository.dart';

class ForgetPasswordUseCase extends BaseUseCase<ForgetPasswordUseCaseInput, ForgetPassword> {

  final Repository _repository;

  ForgetPasswordUseCase(this._repository);
  @override
  Future<Either<Failure, ForgetPassword>> execute(input) async {
    return await _repository.forgetPassword(input.email);
  }

}

class ForgetPasswordUseCaseInput {
  String email;

  ForgetPasswordUseCaseInput(this.email);
}