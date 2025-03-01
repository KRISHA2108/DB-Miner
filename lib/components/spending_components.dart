import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/catagory_controller.dart';
import '../controller/spending_controller.dart';
import '../model/spending_model.dart';
import '../routes/routes.dart';

class SpendingComponents extends StatefulWidget {
  const SpendingComponents({super.key});

  @override
  State<SpendingComponents> createState() => _SpendingComponentsState();
}

class _SpendingComponentsState extends State<SpendingComponents> {
  @override
  Widget build(BuildContext context) {
    SpendingController spendingController = Get.put(SpendingController());
    CategoryController controller = Get.put(CategoryController());

    return Scaffold(
      backgroundColor: Colors.black,
      // body: Padding(
      //   padding: const EdgeInsets.all(16),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Container(
      //         color: Colors.black,
      //         height: 200,
      //         alignment: Alignment.center,
      //         child: const Image(
      //           image: AssetImage(
      //
      //           ),
      //         ),
      //       ),
      //       const Text(
      //         "No Spending...",
      //         style: TextStyle(
      //           color: Colors.white,
      //           fontSize: 20,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: GetBuilder<SpendingController>(
                builder: (context) {
                  return FutureBuilder(
                    future: spendingController.spendingList,
                    builder: (context, snapshot) {
                      List<SpendingModel> spendingListData =
                          snapshot.data ?? [];
                      return spendingListData.isNotEmpty
                          ? ListView.builder(
                              itemCount: spendingListData.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    spendingController.deleteSpending(index);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          (spendingListData[index].date != null)
                                              ? Text(
                                                  spendingListData[index].date,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : const Text("DD/MM/YYYY"),
                                          // spendingListData[index].time != null
                                          //     ? Text(
                                          //         "${spendingListData[index].time}",
                                          //       )
                                          //     : const Text("HH/MM"),
                                        ],
                                      ),
                                      const Divider(),
                                      ListTile(
                                        subtitle: Text(
                                          spendingListData[index].mode ==
                                                  "Online"
                                              ? "💳  ${spendingListData[index].mode}"
                                              : "💸  ${spendingListData[index].mode}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        title: Text(
                                          "${spendingListData[index].name}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        trailing: Text(
                                          "\$ ${spendingListData[index].amount}",
                                          style: const TextStyle(
                                            color: Color(0xffECB148),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  child: Image.asset(
                                    "assets/gif/spending.gif",
                                    height: 200,
                                  ),
                                ),
                                const Text(
                                  "No Spending...",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffECB148),
        onPressed: () {
          Navigator.pushNamed(
            context,
            GetRoutes.allSpending,
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
