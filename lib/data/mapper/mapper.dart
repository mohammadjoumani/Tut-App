import 'package:tut_app/data/response/responses.dart';
import '../../app/constants.dart';
import '../../domain/model/models.dart';
import 'package:tut_app/app/extensions.dart';

extension CustomerResponseMapper on CustomerResponse {
  Customer toDomain() {
    return Customer(
      id?.orEmpty() ?? Constants.empty,
      name?.orEmpty() ?? Constants.empty,
      numOfNotifications?.orZero() ?? Constants.zero,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse {
  Contacts toDomain() {
    return Contacts(
        phone?.orEmpty() ?? Constants.empty,
        email?.orEmpty() ?? Constants.empty,
        link?.orEmpty() ?? Constants.empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse {
  Authentication toDomain() {
    return Authentication(customer?.toDomain(), contacts?.toDomain());
  }
}

extension ForgetPasswordResponseMapper on ForgetPasswordResponse {
  ForgetPassword toDomain() {
    return ForgetPassword(
      support?.orEmpty() ?? Constants.empty,
    );
  }
}

extension ServiceResponseMapper on ServiceResponse {
  Service toDomain() {
    return Service(
      id?.orZero() ?? Constants.zero,
      image?.orEmpty() ?? Constants.empty,
      title?.orEmpty() ?? Constants.empty,
    );
  }
}

extension BannerResponseMapper on BannerResponse {
  BannerAd toDomain() {
    return BannerAd(
      id?.orZero() ?? Constants.zero,
      link?.orEmpty() ?? Constants.empty,
      image?.orEmpty() ?? Constants.empty,
      title?.orEmpty() ?? Constants.empty,
    );
  }
}

extension StoreResponseMapper on StoreResponse {
  Store toDomain() {
    return Store(
      id?.orZero() ?? Constants.zero,
      image?.orEmpty() ?? Constants.empty,
      title?.orEmpty() ?? Constants.empty,
    );
  }
}

extension HomeDataResponseMapper on HomeDataResponse {
  HomeData toDomain() {
    List<Service> serviceList = (services?.map((serviceResponse) => serviceResponse.toDomain()) ?? const Iterable.empty()).cast<Service>().toList();
    List<BannerAd> bannerList = (banners?.map((bannerResponse) => bannerResponse.toDomain()) ?? const Iterable.empty()).cast<BannerAd>().toList();
    List<Store> storeList = (stores?.map((storeResponse) => storeResponse.toDomain()) ?? const Iterable.empty()).cast<Store>().toList();
    return HomeData(serviceList, bannerList, storeList);
  }
}

extension HomeResponseMapper on HomeResponse {
  HomeObject toDomain() {
    return HomeObject(data?.toDomain());
  }
}

// List<Service> serviceList = (this.data?.services?.map((serviceResponse) => serviceResponse.toDomain()) ?? const Iterable.empty()).cast<Service>().toList();
// List<BannerAd> bannerList = (this.data?.banners?.map((bannerResponse) => bannerResponse.toDomain()) ?? const Iterable.empty()).cast<BannerAd>().toList();
// List<Store> storeList = (this.data?.stores?.map((storeResponse) => storeResponse.toDomain()) ?? const Iterable.empty()).cast<Store>().toList();
// var data = HomeData(serviceList, bannerList, storeList);

// extension StoreResponsesMapper on List<StoreResponse> {
//   List<Store> toDomain() {
//     return (map((store) => store.toDomain())).cast<Store>().toList();
//   }
// }

