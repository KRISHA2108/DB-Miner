import 'package:budget_tracker/controller/catagory_controller.dart';
import 'package:budget_tracker/model/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCategoryComponents extends StatelessWidget {
  const AllCategoryComponents({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryController controller = Get.put(CategoryController());
    return Stack(
      children: [
        Container(
          color: Colors.black,
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              TextField(
                onChanged: (val) async {
                  controller.searchData(val: val);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  prefixIcon: Icon(CupertinoIcons.search),
                  hintText: "Search",
                ),
                style: const TextStyle(color: Colors.white),
              ),
              Expanded(
                child: GetBuilder<CategoryController>(
                  builder: (context) {
                    return FutureBuilder(
                        future: controller.allCategory,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasData) {
                            List<CategoryModel> categoryListData =
                                snapshot.data ?? [];
                            return ListView.builder(
                              itemCount: categoryListData.length,
                              itemBuilder: (context, index) {
                                CategoryModel data = CategoryModel(
                                    id: categoryListData[index].id,
                                    name: categoryListData[index].name,
                                    image: categoryListData[index].image);
                                return GestureDetector(
                                  onTap: () {
                                    showCupertinoModalPopup(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoActionSheet(
                                          actions: [
                                            CupertinoActionSheetAction(
                                                child: const Column(
                                                  children: [
                                                    Text("Edit"),
                                                  ],
                                                ),
                                                onPressed: () {}),
                                            CupertinoActionSheetAction(
                                              child: const Text("Delete"),
                                              onPressed: () {
                                                controller.deleteCategory(
                                                    id: categoryListData[index]
                                                        .id);
                                                controller.fetchCategoryData();
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Card(
                                    color: Colors.grey.shade900,
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 15,
                                        backgroundImage:
                                            MemoryImage(data.image),
                                      ),
                                      title: Text(
                                        categoryListData[index].name,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          return const Center(
                            child: Text(
                              "No Data Found",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        });
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
