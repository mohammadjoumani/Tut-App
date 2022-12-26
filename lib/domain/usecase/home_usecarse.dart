import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/domain/usecase/base_usercase.dart';

import '../repository/repository.dart';

class HomeDataUseCase extends BaseUseCase<void, HomeObject> {
  final Repository _repository;

  HomeDataUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(input) async {
    return await _repository.getHomeData();
  }
}
