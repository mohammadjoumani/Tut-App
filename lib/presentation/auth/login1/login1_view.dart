import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/auth/login/viewmodel/login_viewmodel.dart';
import 'package:tut_app/presentation/auth/login1/bloc/login_bloc.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';

import '../../resources/asset_manger.dart';
import '../../resources/values_manager.dart';

class LoginView1 extends StatefulWidget {
  const LoginView1({Key? key}) : super(key: key);

  @override
  State<LoginView1> createState() => _LoginViewState1();
}

class _LoginViewState1 extends State<LoginView1> {
  // final LoginViewModel _viewModel = instance<LoginViewModel>();
  // final AppPreferences _appPref = instance<AppPreferences>();
  // final LoginViewModel _viewModel = LoginViewModel();
  final _loginBloc = instance<LoginBloc>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //
  // _bind() {
  //   // _viewModel.start();
  //
  //   _userNameController.addListener(() => _viewModel.setUserName(_userNameController.text));
  //   _userPasswordController.addListener(() => _viewModel.setPassword(_userPasswordController.text));
  //
  //   _viewModel.isUserLoggedInSuccessfullyStreamController.stream.listen((isLoggedIn) {
  //     if(isLoggedIn) {
  //       SchedulerBinding.instance.addPostFrameCallback((_) {
  //         Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
  //       });
  //       _appPref.setUserLogged();
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _loginBloc,
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
              backgroundColor: ColorManager.white,
              body: state is LoginLoadingState
                  ? Container()
                  : state is LoginSuccessState
                  ? _getContentWidget(context)
                  : state is LoginFailureState
                  ? Text("fasdf")
                  : _getContentWidget(context));
        },
      ),
    );
  }

  @override
  void initState() {
    // _bind();
    super.initState();
  }

  @override
  void dispose() {
    // _viewModel.dispose();
    super.dispose();
  }

  Widget _getContentWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
              const SizedBox(height: AppSize.s28),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: TextFormField(
                  controller: _userNameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: AppStrings.username,
                      labelText: AppStrings.username,
                      errorText: null
                    //(snapShot.data ?? true)
                    // ? null
                    // : AppStrings.usernameError
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s28),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: TextFormField(
                  controller: _userPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      hintText: AppStrings.password,
                      labelText: AppStrings.password,
                      errorText: null
                    // (snapShot.data ?? true)
                    //     ? null
                    //     : AppStrings.passwordError
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: SizedBox(
                  width: double.infinity,
                  height: AppSize.s40,
                  child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<LoginBloc>(context)
                          .add(LoginSubmitEvent(email: _userNameController.text
                              .toString(), password: _userPasswordController
                              .text.toString()));
                      }, child: const Text(AppStrings.login)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(Routes.forgotPasswordRoute);
                        },
                        child: Text(AppStrings.forgetPassword)),
                    TextButton(
                        onPressed: () {}, child: Text(AppStrings.registerText)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
