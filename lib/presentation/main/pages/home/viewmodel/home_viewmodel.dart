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
  final _dataStreamController = BehaviorSubject<HomeViewObject>();

  HomeDataUseCase _homeDataUseCase;

  HomeViewModel(this._homeDataUseCase);

  @override
  void start() {
    _getHomeData();
  }

  @override
  void dispose() {
    _dataStreamController.close();
  }

  //region Inputs

  @override
  Sink get inputHomeData => _dataStreamController.sink;

  // @override
  // Sink get inputServices => _servicesStreamController.sink;
  //
  // @override
  // Sink get inputStores => _storesStreamController.sink;

  void _getHomeData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeDataUseCase.execute(Void)).fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  StateRendererType.fullScreenErrorState, failure.message))
            }, (homeObject) {
      // right -> data (success)
      // content
      inputState.add(ContentState());
      inputHomeData.add(HomeViewObject(homeObject.data!.stores!,
          homeObject.data!.services!, homeObject.data!.banners!));
      // navigate to main screen
    });
  }

  //endregion

  //region Outputs

  @override
  Stream<HomeViewObject> get outputHomeData =>
      _dataStreamController.stream.map((data) => data);

// @override
// Stream<List<Service>> get outServices =>
//     _servicesStreamController.stream.map((services) => services);
//
// @override
// Stream<List<Store>> get outStores =>
//     _storesStreamController.stream.map((stores) => stores);

//endregion

  //region Private fun

//endregion
}

abstract class HomeViewModelInput {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutput {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  List<Store> stores;
  List<Service> services;
  List<BannerAd> banners;

  HomeViewObject(this.stores, this.services, this.banners);
}
