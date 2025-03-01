import 'package:budget_tracker/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetTracker extends StatelessWidget {
  const BudgetTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: GetRoutes.routes,
    );
  }
}
