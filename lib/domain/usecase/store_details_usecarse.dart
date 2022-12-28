import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/domain/usecase/base_usercase.dart';

import '../repository/repository.dart';

class StoreDetailsUseCase extends BaseUseCase<void, StoreDetails> {
  final Repository _repository;

  StoreDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, StoreDetails>> execute(input) async {
    return await _repository.getStoreDetails();
  }
}
