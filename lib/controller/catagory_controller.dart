import 'dart:developer';
import 'package:budget_tracker/helper/db_helper.dart';
import 'package:budget_tracker/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  int? categoryIndex;
  Future<List<CategoryModel>>? allCategory;

  CategoryController() {
    fetchCategoryData();
    update();
  }

  void getCategoryIndex({required int index}) {
    categoryIndex = index;
    update();
  }

  void assignDefaultVal() {
    categoryIndex = null;
    update();
  }

  Future<void> addCategoryData({
    required String name,
    required Uint8List image,
  }) async {
    int? res = await DBHelper.dbHelper.insertCategory(name: name, image: image);

    if (res != null) {
      Get.snackbar(
        "Insert",
        "$name category is inserted...",
        colorText: Colors.white,
        backgroundColor: Colors.green.shade300,
      );
    } else {
      Get.snackbar(
        "Failed",
        "$name category is Insertion failed....",
        colorText: Colors.white,
        backgroundColor: Colors.red.shade300,
      );
    }
    fetchCategoryData();
    update();
  }

  // Delete Record
  Future<void> deleteCategory({required int id}) async {
    int? res = await DBHelper.dbHelper.deleteCategoryData(id: id);

    if (res != null) {
      Get.snackbar(
        'DELETED',
        "Category is deleted...",
        backgroundColor: Colors.green.withOpacity(0.5),
      );
      fetchCategoryData();
    } else {
      Get.snackbar(
        'Failed',
        "Category is deletion failed...",
        backgroundColor: Colors.red.withOpacity(0.5),
      );
    }
    fetchCategoryData();
    update();
  }

  // Fetch Records
  void fetchCategoryData() {
    allCategory = DBHelper.dbHelper.fetchCategory();
    log("$allCategory");
    update();
  }

  //Live Search
  void searchData({required String val}) {
    allCategory = DBHelper.dbHelper.liveSearchCategory(search: val);

    update();
  }

  // Update Record
  Future<void> updateCategoryData({required CategoryModel model}) async {
    int? res = await DBHelper.dbHelper.updateCategory(model: model);

    if (res != null) {
      fetchCategoryData();
      Get.snackbar(
        'Update',
        "Category is updated...",
        backgroundColor: Colors.green.withOpacity(0.7),
      );
    } else {
      Get.snackbar(
        'Failed',
        "Category is updation failed...",
        backgroundColor: Colors.red.withOpacity(0.7),
      );
    }

    update();
  }
}
