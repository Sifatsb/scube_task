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
            itemCount: controller.projectsList.length + 1,
            itemBuilder: (context, index) {
              if (index < controller.projectsList.length) {
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
                      Text(controller.projectsList[index].projectName ?? 'No Data'),
                      Text(controller.projectsList[index].assignedEngineer ?? 'No Data'),
                      // IconButton(onPressed: (){
                      // }, icon: const Icon(Icons.more_vert_outlined))

                      PopupMenuButton<int>(
                        // padding: EdgeInsets.zero,
                        color: Colors.white,
                        iconColor: Colors.white,
                        child:  const Icon(Icons.more_vert_outlined),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: (){
                              controller.showDetailsBottomSheet(index: index);
                            },
                            child:  Text("View".tr),
                          ),
                          const PopupMenuDivider(),
                          PopupMenuItem(
                            onTap: (){

                            },
                            child:  Text("Add".tr),
                          ),
                          const PopupMenuDivider(),
                          PopupMenuItem(
                            onTap: (){

                              controller.startDateTextController.text = controller.projectsList[index].startDate ?? '';
                              controller.endDateTextController.text = controller.projectsList[index].endDate ?? '';
                              controller.startDayTextController.text = controller.projectsList[index].startDayOfYear.toString() ?? '';
                              controller.endDayTextController.text = controller.projectsList[index] .endDayOfYear.toString() ?? '';
                              controller.projectNameTextController.text = controller.projectsList[index].projectName ?? '';
                              controller.projectUpdateTextController.text = controller.projectsList[index].projectUpdate ?? '';
                              controller.engineerTextController.text = controller.projectsList[index].assignedEngineer ?? '';
                              controller.technicianTextController.text = controller.projectsList[index].assignedTechnician ?? '';
                              controller.durationTextController.text = controller.projectsList[index].duration.toString() ?? '';

                              controller.editInfoBottomSheet(index: index);
                            },
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
