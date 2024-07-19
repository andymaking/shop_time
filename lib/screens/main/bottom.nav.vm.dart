

import 'package:flutter/material.dart';

import '../../widget/app-bar-widget.dart';
import '../base-vm.dart';
import 'cart/cart.ui.dart';
import 'home/home.ui.dart';
import 'profile/profile-home.ui.dart';

class BottomNavigationViewModel extends BaseViewModel {


  init({int? initialIndex})async{
    selectedPage = initialIndex??0;
    notifyListeners();
    appCache.initialIndex = selectedPage;
  }


  int selectedPage = 0;

  void onNavigationItem(index) {
    selectedPage = index;
    notifyListeners();
  }

  List<Widget> screens = [
    const HomeView(),
    ProfileHomeScreen(),
    CartHomeScreen(),

  ];
}