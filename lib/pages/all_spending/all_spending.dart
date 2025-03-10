import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/catagory_components.dart';
import '../../components/catagory_components.dart';
import '../../components/catagory_components.dart';
import '../../controller/catagory_controller.dart';
import '../../controller/spending_controller.dart';
import '../../model/category_model.dart';
import '../../model/spending_model.dart';

class AllSpending extends StatefulWidget {
  const AllSpending({super.key});

  @override
  State<AllSpending> createState() => _AllSpendingState();
}

class _AllSpendingState extends State<AllSpending> {
  @override
  Widget build(BuildContext context) {
    CategoryController categoryController = Get.put(CategoryController());
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    SpendingController spendingController = Get.put(SpendingController());
    TextEditingController textController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (val) =>
                    (val!.isEmpty) ? "Amount can't be empty" : null,
                controller: amountController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Color(0xffECB148)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Color(0xffECB148)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  prefixIcon: Icon(
                    Icons.currency_rupee_rounded,
                    color: Color(0xffECB148),
                  ),
                  hintText: "Enter Amount",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // TextFormField(
              //   decoration: const InputDecoration(
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.all(Radius.circular(12)),
              //       borderSide: BorderSide(color: Color(0xffECB148)),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.all(Radius.circular(12)),
              //       borderSide: BorderSide(color: Color(0xffECB148)),
              //     ),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.all(Radius.circular(12)),
              //     ),
              //     prefixIcon: Icon(
              //       Icons.calendar_month,
              //       color: Color(0xffECB148),
              //     ),
              //     hintText: "Enter Date",
              //   ),
              // ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GetBuilder<CategoryController>(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            BottomSheet(
                              onClosing: () {},
                              builder: (context) {
                                return Container(
                                  padding: const EdgeInsets.all(16),
                                  height: 128,
                                  color: Colors.black,
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      RadioMenuButton(
                                        onChanged: spendingController.getMode,
                                        value: "Online",
                                        groupValue: spendingController.mode,
                                        child: const Text(
                                          "Online",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      RadioMenuButton(
                                        onChanged: spendingController.getMode,
                                        value: "Offline",
                                        groupValue: spendingController.mode,
                                        child: const Text(
                                          "Offline",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 130,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xffECB148),
                              width: 2,
                            ),
                          ),
                          child: GetBuilder<SpendingController>(
                              builder: (context) {
                            return Text(
                              spendingController.mode ?? "Mode",
                              style: const TextStyle(
                                color: Color(0xffECB148),
                                fontSize: 18,
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        backgroundColor: Colors.black,
                        BottomSheet(
                          onClosing: () {},
                          builder: (context) {
                            return Container(
                              color: Colors.black,
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Category",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: FutureBuilder(
                                      future: categoryController.allCategory,
                                      builder: (context, snapshot) {
                                        {
                                          List<CategoryModel> categoryListData =
                                              snapshot.data ?? [];
                                          return ListView.builder(
                                            itemCount: categoryListData.length,
                                            itemBuilder: (context, index) {
                                              return GetBuilder<
                                                  CategoryController>(
                                                builder: (context) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      categoryController
                                                          .getCategoryIndex(
                                                              index: index);

                                                      spendingController
                                                          .getSpendingImage(
                                                              categoryListData[
                                                                      index]
                                                                  .image);
                                                    },
                                                    child: categoryController
                                                                .categoryIndex ==
                                                            index
                                                        ? Card(
                                                            color: Colors
                                                                .grey.shade900,
                                                            child: ListTile(
                                                              leading:
                                                                  CircleAvatar(
                                                                backgroundImage:
                                                                    MemoryImage(
                                                                  categoryListData[
                                                                          index]
                                                                      .image,
                                                                ),
                                                              ),
                                                              title: Text(
                                                                categoryListData[
                                                                        index]
                                                                    .name,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              trailing: categoryController
                                                                          .categoryIndex ==
                                                                      index
                                                                  ? const Icon(
                                                                      Icons
                                                                          .check,
                                                                      color: Colors
                                                                          .green,
                                                                    )
                                                                  : const Icon(
                                                                      Icons
                                                                          .check,
                                                                      color: Colors
                                                                          .transparent,
                                                                    ),
                                                            ),
                                                          )
                                                        : ListTile(
                                                            leading:
                                                                CircleAvatar(
                                                              backgroundImage:
                                                                  MemoryImage(
                                                                categoryListData[
                                                                        index]
                                                                    .image,
                                                              ),
                                                            ),
                                                            title: Text(
                                                              categoryListData[
                                                                      index]
                                                                  .name,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                            trailing: categoryController
                                                                        .categoryIndex ==
                                                                    index
                                                                ? const Icon(
                                                                    Icons.check,
                                                                    color: Colors
                                                                        .green,
                                                                  )
                                                                : const Icon(
                                                                    Icons.check,
                                                                    color: Colors
                                                                        .transparent,
                                                                  ),
                                                          ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 190,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xffECB148),
                          width: 2,
                        ),
                      ),
                      child: GetBuilder<CategoryController>(
                        builder: (context) {
                          return FutureBuilder(
                              future: categoryController.allCategory,
                              builder: (context, snapshot) {
                                List<CategoryModel> categoryListData =
                                    snapshot.data ?? [];
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    (categoryController.categoryIndex != null)
                                        ? CircleAvatar(
                                            backgroundImage: MemoryImage(
                                                categoryListData[
                                                        categoryController
                                                            .categoryIndex!]
                                                    .image),
                                            radius: 15,
                                          )
                                        : const CircleAvatar(),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      (categoryController.categoryIndex == null)
                                          ? "Category"
                                          : categoryListData[categoryController
                                                  .categoryIndex!]
                                              .name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: textController,
                decoration: const InputDecoration(
                  labelText: "Enter Name",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Color(0xffECB148)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Color(0xffECB148)),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  // DateTime
                  Expanded(
                    child: GetBuilder<SpendingController>(
                      builder: (_) {
                        return Container(
                          height: 55,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xffECB148),
                              width: 2,
                            ),
                          ),
                          child: TextButton.icon(
                            onPressed: () async {
                              DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2030),
                              );

                              if (date != null) {
                                spendingController.getSpendingDate(date);
                              }
                            },
                            label: (spendingController.dateTime != null)
                                ? Text(
                                    "${spendingController.dateTime?.day}/${spendingController.dateTime?.month}/${spendingController.dateTime?.year}",
                                    style: TextStyle(color: Colors.white),
                                  )
                                : const Text(
                                    "DD/MM/YYYY",
                                    style: TextStyle(color: Colors.white),
                                  ),
                            icon: const Icon(
                              Icons.date_range,
                              size: 20,
                              color: Color(0xffECB148),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // TimeOfDay
                  Expanded(
                    child: GetBuilder<SpendingController>(
                      builder: (_) {
                        return GestureDetector(
                          child: Container(
                            height: 55,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xffECB148),
                                width: 2,
                              ),
                            ),
                            child: TextButton.icon(
                              onPressed: () async {
                                TimeOfDay? time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (time != null) {
                                  spendingController.getSpendingTime(time);
                                }
                              },
                              icon: const Icon(
                                Icons.timer_outlined,
                                color: Color(0xffECB148),
                                size: 20,
                              ),
                              label: (spendingController.timeOfDay != null)
                                  ? Text(
                                      "${spendingController.timeOfDay?.hour}:${spendingController.timeOfDay?.minute}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      "HH:MM",
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              // GetBuilder<SpendingController>(
              //   builder: (_) {
              //     return Container(
              //       height: 55,
              //       width: 200,
              //       alignment: Alignment.center,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(20),
              //         border: Border.all(
              //           color: const Color(0xffECB148),
              //           width: 2,
              //         ),
              //       ),
              //       child: Text(
              //         "Save",
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 18,
              //         ),
              //       ),
              //     );
              //   },
              // ),
              GetBuilder<SpendingController>(
                builder: (context) {
                  return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xffECB148)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: Color(0xffECB148),
                          width: 2,
                        ),
                      ),
                      fixedSize: const Size(150, 50),
                      textStyle: const TextStyle(
                        color: Color(0xffECB148),
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        SpendingModel model = SpendingModel(
                          name: textController.text,
                          amount: num.parse(amountController.text),
                          mode: "${spendingController.mode}",
                          date:
                              "${spendingController.dateTime?.day}/${spendingController.dateTime?.month}/${spendingController.dateTime?.year}",
                        );

                        spendingController.initSpendingData(model);
                        log("=========================:${spendingController.spendingList}:=========================");
                        spendingController.fetchSpendingData();
                        spendingController.clear();
                        textController.clear();
                        spendingController.dateTime = null;
                        spendingController.timeOfDay = null;
                        amountController.clear();
                      }
                    },
                    child: const Text("SAVE",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
