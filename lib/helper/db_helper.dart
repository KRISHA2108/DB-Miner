import 'package:budget_tracker/model/category_model.dart';
import 'package:budget_tracker/model/spending_model.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();
  static DBHelper dbHelper = DBHelper._();
  String categoryTable = "category";
  String? categoryId = "category_id";
  String? categoryName = "category_name";
  String? categoryImage = "category_image";
  String categoryImageIndex = "category_image_index";

  String spendingTable = "spending";
  String spendingId = "spending_id";
  String spendingName = "spending_name";
  String spendingAmount = "spending_amount";
  String spendingMode = "spending_mode";
  String spendingDate = "spending_date";
  String spendingCategoryId = "spending_category_id";

  Database? db;
  Logger logger = Logger();

  // TODO: Create Database
  Future<void> initDB() async {
    String databasePath = await getDatabasesPath();

    String path = "${databasePath}budget.db";
    // TODO: Create Tables
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        String query = '''CREATE TABLE $categoryTable(
          $categoryId INTEGER PRIMARY KEY AUTOINCREMENT,
          $categoryName TEXT NOT NULL,
          $categoryImage BLOB NOT NULL
        );''';
        await db.execute(query).then(
          (value) {
            logger.i("Table Created");
          },
        ).onError(
          (error, _) {
            logger.e(error);
          },
        );

        String que = '''CREATE TABLE $spendingTable(
          $spendingId INTEGER PRIMARY KEY AUTOINCREMENT,
          $spendingName TEXT NOT NULL,
          $spendingAmount REAL NOT NULL,  
          $spendingMode TEXT NOT NULL,
          $spendingDate TEXT NOT NULL
          );''';

        await db.execute(que).then(
          (value) {
            logger.i("Table Created");
          },
        ).onError(
          (error, _) {
            logger.e(error);
          },
        );
      },
    );
  }

  //TODO: Insert Data
  Future<int?> insertCategory({
    required String name,
    required Uint8List image,
  }) async {
    await initDB();

    String query =
        "INSERT INTO $categoryTable ($categoryName, $categoryImage) VALUES(?, ?);";

    List arg = [name, image];

    return await db?.rawInsert(query, arg);
  }

  Future<int?> insertSpending({required SpendingModel model}) async {
    await initDB();

    String que =
        "INSERT INTO $spendingTable ($spendingName,$spendingAmount,$spendingMode,$spendingDate) VALUES(?, ?, ?, ?);";

    List args = [
      model.name,
      model.amount,
      model.mode,
      model.date,
    ];

    return await db?.rawInsert(que, args);
  }

  // TODO: FETCH ALL RECORDS
  Future<List<CategoryModel>> fetchCategory() async {
    await initDB();

    String query = "SELECT * FROM $categoryTable;";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    return res.map((e) => CategoryModel.fromToMap(e)).toList();
  }

  Future<List<SpendingModel>> fetchSpending() async {
    await initDB();

    String que = "SELECT *  FROM $spendingTable;";

    List<Map<String, dynamic>> res = await db?.rawQuery(que) ?? [];

    return res
        .map(
          (e) => SpendingModel.formMap(data: e),
        )
        .toList();
  }

  Future<CategoryModel> fetchSingleCategory({required int id}) async {
    await initDB();

    String query = "SELECT * FROM $categoryTable WHERE $categoryId = $id;";

    List<Map<String, dynamic>> res = await db?.rawQuery(query) ?? [];

    return CategoryModel(
      id: res[0]['category_id'],
      name: res[0][categoryName],
      image: res[0][categoryImage],
      // index: res[0][categoryImageIndex],
    );
  }

  Future<List<CategoryModel>> liveSearchCategory({
    required String search,
  }) async {
    await initDB();

    String query =
        "SELECT * FROM $categoryTable WHERE $categoryName LIKE '%$search%';";

    List<Map<String, dynamic>> res = await db?.rawQuery(query) ?? [];

    return res.map((e) => CategoryModel.fromToMap(e)).toList();
  }

  Future<int?> updateCategory({required CategoryModel model}) async {
    await initDB();

    String query =
        "UPDATE $categoryTable SET $categoryName = ?, $categoryImage = ? WHERE category_id = ${model.id};";
    List arg = [
      model.name,
      model.image,
      // model.index,
    ];
    return await db?.rawUpdate(query, arg);
  }

  // TODO: DELETE RECORD
  Future<int?> deleteCategoryData({required int id}) async {
    await initDB();
    String query = "DELETE FROM $categoryTable WHERE $categoryId = $id";
    return await db?.rawDelete(query);
  }
  //  spending Data delete

  Future<int?> deleteSpendingData(int id) async {
    await initDB();
    String query = "DELETE FROM $spendingTable WHERE $spendingId = $id";
    return await db?.rawDelete(query);
  }

  //  editCategoryData
  Future<int?> editCategoryData(CategoryModel model) async {
    await initDB();

    String query =
        "UPDATE $categoryTable SET $categoryName = ?,$categoryImageIndex = ?,$categoryImage = ? WHERE $categoryId = ${model.id};";
    List args = [
      model.name,
      // model.imageIndex,
      model.image,
    ];
    return await db?.rawUpdate(query, args);
  }
  // Future<int?> deleteCategory({required int id}) async {
  //   await initDB();
  //
  //   String query = "DELETE FROM $categoryTable WHERE category_id=$id;";
  //
  //   return await db?.rawDelete(query);
  // }
}
