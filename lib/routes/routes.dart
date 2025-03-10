import 'package:budget_tracker/pages/all_spending/all_spending.dart';
import 'package:get/get.dart';
import '../pages/home/view/bottom_navigation.dart';
import '../pages/splash/view/splash_screen.dart';

class GetRoutes {
  static const String splash = '/';
  static const String bottomNavigation = '/bottomNavigation';
  static const String spending = '/spending';
  static const String allSpending = '/allSpending';
  static const String allCategory = '/allCategory';
  static const String category = '/category';

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: bottomNavigation, page: () => const BottomNavigation()),
    GetPage(name: allSpending, page: () => const AllSpending()),
  ];
}
