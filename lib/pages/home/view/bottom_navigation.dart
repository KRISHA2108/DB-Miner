import 'package:budget_tracker/components/all_catagory_components.dart';
import 'package:budget_tracker/components/catagory_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/spending_components.dart';
import '../../../controller/get_controller.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  GetController controller = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (value) {
          controller.changePage(value);
        },
        children: const [
          SpendingComponents(),
          CategoryComponent(),
          AllCategoryComponents(),
        ],
      ),
      bottomNavigationBar: Obx(
        () {
          return NavigationBar(
            selectedIndex: controller.selectIndex.value,
            onDestinationSelected: (value) {
              controller.changeIndex(value);
              controller.changePage(value);
            },
            backgroundColor: Colors.black,
            indicatorColor: const Color(0xffECB148),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.all_inbox_outlined),
                label: 'Spending',
              ),
              NavigationDestination(
                icon: Icon(Icons.account_balance_wallet),
                label: 'Wallet',
              ),
              NavigationDestination(
                icon: Icon(Icons.category),
                label: 'Category',
                selectedIcon: Icon(
                  Icons.category,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
