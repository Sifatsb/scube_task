import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
            itemCount: controller.projects.length + 1,
            itemBuilder: (context, index) {
              if (index < controller.projects.length) {
                return Container(
                  padding: const EdgeInsets.all(6),
                  // margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: index % 2 == 1 ? Colors.white : Colors.grey.shade200,
                    
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(controller.projects[index].projectName ?? 'No Data'),
                      Text(controller.projects[index].assignedEngineer ?? 'No Data'),
                      // IconButton(onPressed: (){
                      // }, icon: const Icon(Icons.more_vert_outlined))

                      PopupMenuButton<int>(
                        // padding: EdgeInsets.zero,
                        color: Colors.white,
                        iconColor: Colors.white,
                        child:  const Icon(Icons.more_vert_outlined),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            onTap: (){},
                            child:  Text("View".tr),
                          ),
                          const PopupMenuDivider(),
                          PopupMenuItem(
                            value: 2,
                            onTap: (){},
                            child:  Text("Add".tr),
                          ),
                          const PopupMenuDivider(),
                          PopupMenuItem(
                            value: 2,
                            onTap: (){},
                            child:  Text("Update".tr),
                          ),
                        ],
                      )

                    ],
                  ),
                );
              } else if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Center(child: Text('No data available', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),));
              }
            },
            controller: controller.scrollController,
          )),
    );
  }
}
