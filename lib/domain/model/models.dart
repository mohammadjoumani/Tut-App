// region onBoarding models

class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlide;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlide, this.currentIndex);
}

//endregion

//region Login

class Customer {
  String id;
  String name;
  int numOfNotifications;

  Customer(this.id, this.name, this.numOfNotifications);
}

class Contacts {
  String phone;
  String email;
  String link;

  Contacts(this.phone, this.email, this.link);
}

class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication(this.customer, this.contacts);
}

//endregion

//region Forget Password

class ForgetPassword {
  String support;

  ForgetPassword(this.support);
}

//endregion

//region Home Data

class Service {
  int id;

  String title;

  String image;

  Service(this.id, this.image, this.title);
}

class BannerAd {
  int id;

  String link;

  String title;

  String image;

  BannerAd(this.id, this.link, this.title, this.image);
}

class Store {
  int id;

  String title;

  String image;

  Store(this.id, this.image, this.title);
}

class HomeData {
  List<Service>? services;

  List<BannerAd>? banners;

  List<Store>? stores;

  HomeData(this.services, this.banners, this.stores);
}

//endregion
