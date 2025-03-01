import 'package:budget_tracker/controller/catagory_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

List<Map<String, dynamic>> categoryList = [
  {
    "name": "beauty",
    "images": "assets/images/beauty.jpg",
  },
  {
    "name": "bills",
    "images": "assets/images/bills.jpg",
  },
  {
    "name": "car",
    "images": "assets/images/car.jpg",
  },
  {
    "name": "clothing",
    "images": "assets/images/clothing.jpg",
  },
  {
    "name": "education",
    "images": "assets/images/education.jpg",
  },
  {
    "name": "electronics",
    "images": "assets/images/electronics.jpg",
  },
  {
    "name": "sports",
    "images": "assets/images/sport.jpg",
  },
  {
    "name": "food",
    "images": "assets/images/food.jpg",
  },
  {
    "name": "health",
    "images": "assets/images/health.jpg",
  },
  {
    "name": "home",
    "images": "assets/images/home.jpg",
  },
  {
    "name": "insurance",
    "images": "assets/images/insurance.jpg",
  },
  {
    "name": "movie",
    "images": "assets/images/movie.jpg",
  },
  {
    "name": "refund",
    "images": "assets/images/refund.jpg",
  },
  {
    "name": "salary",
    "images": "assets/images/salary.jpg",
  },
  {
    "name": "shopping",
    "images": "assets/images/shopping.jpg",
  },
  {
    "name": "social",
    "images": "assets/images/social.jpg",
  },
  {
    "name": "sport",
    "images": "assets/images/sport.jpg",
  },
  {
    "name": "tax",
    "images": "assets/images/tax.jpg",
  },
  {
    "name": "telephone",
    "images": "assets/images/telephone.jpg",
  },
  {
    "name": "transport",
    "images": "assets/images/transportation.jpg",
  },
];

GlobalKey<FormState> formKey = GlobalKey<FormState>();
TextEditingController categoryController = TextEditingController();

class CategoryComponent extends StatelessWidget {
  const CategoryComponent({super.key});

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
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Category !!",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  controller: categoryController,
                  validator: (val) =>
                      val!.isEmpty ? "This field is Required..." : null,
                  decoration: InputDecoration(
                    labelText: "Category",
                    hintText: "Enter category...",
                    hintStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.deepPurple,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.redAccent,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: GetBuilder<CategoryController>(
                    builder: (context) {
                      return ListView.builder(
                        itemCount: categoryList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              controller.getCategoryIndex(index: index);
                            },
                            child: ListTile(
                              leading: Image.asset(
                                categoryList[index]["images"],
                                height: 20,
                              ),
                              title: Text(
                                categoryList[index]["name"].toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              trailing: controller.categoryIndex == index
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    )
                                  : const Icon(
                                      Icons.check,
                                      color: Colors.transparent,
                                    ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton.extended(
                      backgroundColor: Color(0xffECB148),
                      onPressed: () async {
                        if (formKey.currentState!.validate() &&
                            controller.categoryIndex != null) {
                          String name = categoryController.text;

                          String assetPath =
                              categoryList[controller.categoryIndex!]["images"];

                          ByteData byteData = await rootBundle.load(assetPath);

                          Uint8List image = byteData.buffer.asUint8List();

                          controller.addCategoryData(name: name, image: image);
                        }
                        categoryController.clear();
                        controller.assignDefaultVal();
                        controller.fetchCategoryData();
                      },
                      icon: const Icon(CupertinoIcons.add_circled),
                      label: const Text("Add Category"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
