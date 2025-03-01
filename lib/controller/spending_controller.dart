import 'package:budget_tracker/helper/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../model/spending_model.dart';

class SpendingController extends GetxController {
  String? mode;
  Future<List<SpendingModel>>? spendingList;
  DateTime? dateTime;
  TimeOfDay? timeOfDay;
  Uint8List? image;
  SpendingController() {
    fetchSpendingData();
    update();
  }

  void getMode(String? mode) {
    this.mode = mode;
    update();
    Get.back();
  }

  void clear() {
    mode = null;
    update();
  }

  void getSpendingImage(Uint8List? image) {
    this.image = image;
    update();
  }

  Future<void> initSpendingData(SpendingModel model) async {
    int? result = await DBHelper.dbHelper.insertSpending(model: model);
    if (result != null) {
      Get.snackbar(
        "Insert",
        "category is inserted...",
        colorText: Colors.white,
        backgroundColor: Colors.green.shade300,
      );
    } else {
      Get.snackbar(
        "Failed",
        "category is Insertion failed....",
        colorText: Colors.white,
        backgroundColor: Colors.red.shade300,
      );
    }
    update();
  }

  void fetchSpendingData() {
    spendingList = DBHelper.dbHelper.fetchSpending();
    update();
  }

  Future<void> deleteSpending(int id) async {
    int? result = await DBHelper.dbHelper.deleteSpendingData(id);
    if (result != null) {
      Get.snackbar(
        "Delete",
        "category is Deleted...",
        colorText: Colors.white,
        backgroundColor: Colors.green.shade300,
      );
    } else {
      Get.snackbar(
        "Failed",
        "category is Deletion failed....",
        colorText: Colors.white,
        backgroundColor: Colors.red.shade300,
      );
    }
    fetchSpendingData();
    update();
  }

  void getSpendingDate(DateTime date) {
    dateTime = date;
    update();
  }

  void getSpendingTime(TimeOfDay time) {
    timeOfDay = time;
    update();
  }
}
