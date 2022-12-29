import 'package:flutter/material.dart';
import 'package:tut_app/presentation/auth/forgot_password/viewmodel/forget_password_viewmodel.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';

import '../../../../app/di.dart';
import '../../../common/state_renderer/state_renderer_impl.dart';
import '../../../resources/asset_manger.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/values_manager.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {

  final ForgetPasswordViewModel _viewModel = instance<ForgetPasswordViewModel>();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();

    _emailController.addListener(() => _viewModel.setEmail(_emailController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data
              ?.getScreenWidget(context, _getContentWidget(),
                  () {_viewModel.forgetPassword();}
          ) ?? _getContentWidget();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.dispose();
  }

  Widget _getContentWidget() {
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
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outIsEmailValid,
                  builder:(context, snapShot) => TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: AppStrings.username,
                        labelText: AppStrings.username,
                        errorText: (snapShot.data ?? true)
                            ? null
                            : AppStrings.invalidEmail
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<bool>(
                    stream: _viewModel.outIsEmailValid,
                    builder:(context, snapShot) => SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                          onPressed: (snapShot.data ?? false)
                              ? () {
                            _viewModel.forgetPassword();
                          } : null,
                          child: const Text(AppStrings.login)),
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: TextButton(
                    onPressed: () {},
                    child: Text(AppStrings.forgetPassword)),
              )
            ],
          ),
        ),
      ),
    );
  }

}


