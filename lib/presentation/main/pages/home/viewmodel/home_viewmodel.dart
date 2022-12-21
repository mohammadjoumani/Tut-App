import 'dart:async';
import 'dart:ffi';

import 'package:rxdart/rxdart.dart';
import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/domain/usecase/home_usecarse.dart';
import 'package:tut_app/presentation/base/base_viewmodel.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  final StreamController _servicesStreamController =
      BehaviorSubject<List<Service>>();
  final StreamController _bannersStreamController =
      BehaviorSubject<List<BannerAd>>();
  final StreamController _storesStreamController =
      BehaviorSubject<List<Store>>();

  HomeDataUseCase _homeDataUseCase;

  HomeViewModel(this._homeDataUseCase);

  @override
  void start() {
    _getHomeData();
  }

  @override
  void dispose() {
    _servicesStreamController.close();
    _bannersStreamController.close();
    _storesStreamController.close();
  }

  //region Inputs

  @override
  Sink get inputBanners => _bannersStreamController.sink;

  @override
  Sink get inputServices => _servicesStreamController.sink;

  @override
  Sink get inputStores => _storesStreamController.sink;

  void _getHomeData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeDataUseCase.execute(Void)).fold(
        (failure) => {
              inputState.add(ErrorState(
                  StateRendererType.fullScreenErrorState, failure.message))
            },
        (data) {
          inputState.add(ContentState());
          inputServices.add(data.services);
          inputBanners.add(data.banners);
          inputStores.add(data.stores);
        });
  }

  //endregion

  //region Outputs

  @override
  Stream<List<BannerAd>> get outBanners =>
      _bannersStreamController.stream.map((banners) => banners);

  @override
  Stream<List<Service>> get outServices =>
      _servicesStreamController.stream.map((services) => services);

  @override
  Stream<List<Store>> get outStores =>
      _storesStreamController.stream.map((stores) => stores);

//endregion

//region Private fun

//endregion
}

abstract class HomeViewModelInput {
  Sink get inputServices;

  Sink get inputBanners;

  Sink get inputStores;
}

abstract class HomeViewModelOutput {
  Stream<List<Service>> get outServices;

  Stream<List<BannerAd>> get outBanners;

  Stream<List<Store>> get outStores;
}
