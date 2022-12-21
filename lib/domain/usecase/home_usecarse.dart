import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/domain/usecase/base_usercase.dart';

import '../repository/repository.dart';

class HomeDataUseCase extends BaseUseCase<void, HomeData> {
  final Repository _repository;

  HomeDataUseCase(this._repository);

  @override
  Future<Either<Failure, HomeData>> execute(input) async {
    return await _repository.getHomeData();
  }
}
