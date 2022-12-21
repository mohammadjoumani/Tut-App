import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/data/network/app_api.dart';
import 'package:tut_app/data/repository/repository_impl.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/domain/usecase/forget_password_usecarse.dart';
import 'package:tut_app/domain/usecase/home_usecarse.dart';
import 'package:tut_app/domain/usecase/login_usecarse.dart';
import 'package:tut_app/domain/usecase/register_usecarse.dart';
import 'package:tut_app/presentation/auth/forgot_password/viewmodel/forget_password_viewmodel.dart';
import 'package:tut_app/presentation/auth/login/viewmodel/login_viewmodel.dart';
import 'package:tut_app/presentation/main/pages/home/viewmodel/home_viewmodel.dart';

import '../data/data_source/remote_data_source.dart';
import '../data/network/dio_factory.dart';
import '../data/network/netword_info.dart';
import '../presentation/auth/register/viewmodel/register_viewmodel.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // SharedPreferences instance
  final sharedPreferences = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // AppPreferences instance
  // final appPreferences = AppPreferences(instance());
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  //NetworkInfo instance
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));
  // print("${GetIt.I.isRegistered<NetworkInfo>()} " + "NetworkInfo");

  //DioFactory instance
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  final dio = await instance<DioFactory>().getDio();

  //AppServiceClient instance
  instance.registerLazySingleton(() => AppServiceClient(dio));

  //RemoteDataSource instance
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));

  //Repository instance
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

void initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
    // instance.registerFactory<LoginBloc>(() => LoginBloc(instance()));
  }
}

void initForgetPasswordModule() {
  if (!GetIt.I.isRegistered<ForgetPasswordUseCase>()) {
    instance.registerFactory<ForgetPasswordUseCase>(() => ForgetPasswordUseCase(instance()));
    instance.registerFactory<ForgetPasswordViewModel>(() => ForgetPasswordViewModel(instance()));
  }
}

void initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(() => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

void initHomeModule() {
  if (!GetIt.I.isRegistered<HomeDataUseCase>()) {
    instance.registerFactory<HomeDataUseCase>(() => HomeDataUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
}
