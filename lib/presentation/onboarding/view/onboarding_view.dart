import 'package:flutter/material.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/presentation/onboarding/viewmodel/onboarding_viewmodel.dart';
import 'package:tut_app/presentation/resources/asset_manger.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';
import '../../../app/di.dart';
import '../../../domain/model/models.dart';
import '../../resources/constants_manager.dart';
import '../../resources/values_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController();
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();
  final AppPreferences _appPref = instance<AppPreferences>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) => _getContentWidget(snapshot.data),
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: AppSize.s0,
          // systemOverlayStyle: SystemUiOverlayStyle(
          //     statusBarColor: ColorManager.white,
          //     statusBarBrightness: Brightness.dark),
        ),
        body: PageView.builder(
            controller: _pageController,
            itemCount: sliderViewObject.numOfSlide,
            onPageChanged: (index) => _viewModel.onPageChanged(index),
            itemBuilder: (context, index) =>
                OnBoarding(sliderObject: sliderViewObject.sliderObject)),
        bottomSheet: Container(
          color: ColorManager.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.loginRoute);
                    _appPref.setOnBoardingScreenViewed();
                  },
                  child: Text(AppStrings.skip.tr(),
                      textAlign: TextAlign.end)),
            ],
          ),
        ),
        bottomNavigationBar: _getBottomSheetWidget(sliderViewObject),
      );
    }
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // left arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.icLeftArrow),
              ),
              onTap: () {
                _pageController.animateToPage(_viewModel.goPrevious(),
                    duration: const Duration(
                        milliseconds: AppConstants.sliderAnimationTime),
                    curve: Curves.bounceInOut);
              },
            ),
          ),

          // circle indicator
          Row(
            children: [
              for (int i = 0; i < sliderViewObject.numOfSlide; i++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i, sliderViewObject.currentIndex),
                )
            ],
          ),

          // right arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
                child: SizedBox(
                  width: AppSize.s20,
                  height: AppSize.s20,
                  child: SvgPicture.asset(ImageAssets.icRightArrow),
                ),
                onTap: () {
                  _pageController.animateToPage(_viewModel.goNext(),
                      duration: const Duration(
                          milliseconds: AppConstants.sliderAnimationTime),
                      curve: Curves.bounceInOut);
                }),
          )
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, int currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAssets.icHollowCircle);
    } else {
      return SvgPicture.asset(ImageAssets.icSolidCircle);
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class OnBoarding extends StatelessWidget {
  final SliderObject sliderObject;

  const OnBoarding({Key? key, required this.sliderObject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSize.s40),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: AppSize.s60),
        SvgPicture.asset(sliderObject.image)
      ],
    );
  }
}
