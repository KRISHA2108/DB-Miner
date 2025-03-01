import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetController extends GetxController {
  RxInt selectIndex = 0.obs;
  RxInt categoryIndex = 0.obs;
  PageController pageController = PageController();

  void changeIndex(int index) {
    selectIndex.value = index;
  }

  void changePage(int index) {
    pageController.animateToPage(index,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
    update();
  }
}
