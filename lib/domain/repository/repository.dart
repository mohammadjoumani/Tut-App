import 'package:dartz/dartz.dart';
import 'package:tut_app/domain/model/models.dart';
import '../../data/network/requests.dart';
import '../../data/network/failure.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);

  Future<Either<Failure, ForgetPassword>> forgetPassword(String email);

  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest);

  Future<Either<Failure, HomeData>> getHomeData();

}

