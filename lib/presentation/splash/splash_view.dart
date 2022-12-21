import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/resources/asset_manger.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/constants_manager.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';

import '../../app/app_prefs.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);


  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AppPreferences _appPref = instance<AppPreferences>();
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() async {
    if(await _appPref.isUserLogged()) {
      Navigator.pushReplacementNamed(context, Routes.mainRoute);
    } else if(await _appPref.isOnBoardingScreenViewed()){
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
    } else {
      Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
    }
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}


