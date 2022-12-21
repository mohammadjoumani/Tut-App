import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:tut_app/presentation/main/pages/home/viewmodel/home_viewmodel.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _viewModel = instance<HomeViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.start();
              }) ??
              _getContentWidget();
        },
      ),
    ));
  }

  Widget _getContentWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getBanners(),
        _getSections(AppStrings.services),
        _getServices(),
        _getSections(AppStrings.stores),
        _getStores(),
      ],
    );
  }

  Widget _getBanners() {
    return StreamBuilder<List<BannerAd>>(
      stream: _viewModel.outBanners,
      builder: (context, snapshot) {
        return _getBannersWidget(snapshot.data);
      },
    );
  }

  Widget _getBannersWidget(List<BannerAd>? banners) {
    if (banners != null) {
      return CarouselSlider(
          items: banners
              .map((banner) => SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: AppSize.s1_5,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(AppSize.s12)),
                        side: BorderSide(
                            color: ColorManager.primary, width: AppSize.s1),
                      ),
                      child: ClipRect(
                        child: Image.network(banner.image, fit: BoxFit.cover),
                      ),
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
              height: AppSize.s90,
              autoPlay: true,
              enableInfiniteScroll: true,
              enlargeCenterPage: true));
    } else {
      return Container();
    }
  }

  Widget _getSections(String title) {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppPadding.p12,
          right: AppPadding.p12,
          top: AppPadding.p12,
          bottom: AppPadding.p2),
      child: Text(title, style: Theme.of(context).textTheme.labelSmall),
    );
  }

  Widget _getServices() {
    return Container();
  }

  Widget _getStores() {
    return Container();
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.dispose();
  }
}
