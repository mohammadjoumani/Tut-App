import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tut_app/presentation/main/pages/home/view/home_page.dart';
import 'package:tut_app/presentation/main/pages/notifications/view/notifications_page.dart';
import 'package:tut_app/presentation/main/pages/search/view/search_page.dart';
import 'package:tut_app/presentation/main/pages/settings/view/settings_page.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';

import '../resources/values_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    HomePage(),
    Notifications(),
    Search(),
    SettingsPage(),
  ];

  List<String> titles = [
    AppStrings.home.tr(),
    AppStrings.notifications.tr(),
    AppStrings.search.tr(),
    AppStrings.settings.tr()
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
          // systemOverlayStyle: SystemUiOverlayStyle(
          //   statusBarColor: ColorManager.primary,
          //   statusBarIconBrightness: Brightness.light,
          //   statusBarBrightness: Brightness.light
          // ),
          title: Text(titles[_currentIndex])),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: ColorManager.lightGrey, spreadRadius: AppSize.s1)
        ]),
        child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: AppStrings.home.tr()),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_outlined),
                  label: AppStrings.notifications.tr()),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search_outlined), label: AppStrings.search.tr()),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined),
                  label: AppStrings.settings.tr())
            ],
            backgroundColor: ColorManager.white,
            selectedItemColor: ColorManager.primary,
            unselectedItemColor: ColorManager.grey,
            currentIndex: _currentIndex,
            onTap: onTap),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
