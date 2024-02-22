import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:scube_task/app/data/constants/app_colors.dart';
import 'package:scube_task/app/data/constants/app_text_style.dart';
import 'package:scube_task/app/modules/home/views/widgets/bottom_sheet_tile.dart';
import 'package:scube_task/app/utilities/extensions/widget.extensions.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: const Text(
          'Project Info',
          style: AppTextStyle.blackFontSize16W700,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
                controller.addInfoBottomSheet();
              },
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)),
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() => Column(
            children: [
              BottomSheetTile(
                title: 'Project Name',
                value: 'Assigned Engineer',
                width: Get.width * 0.411,
                titleTextStyle: AppTextStyle.blackFontSize16W700,
                valueTextStyle: AppTextStyle.blackFontSize16W700,
                color: AppColors.primaryColor,
              ),
              20.verticalSpacing,
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.projectsList.length + 1,
                  itemBuilder: (context, index) {
                    if (index < controller.projectsList.length) {
                      return Container(
                        padding: const EdgeInsets.all(6),
                        // margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: index % 2 == 1
                              ? Colors.white
                              : Colors.grey.shade200,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BottomSheetTile(
                              title:
                                  controller.projectsList[index].projectName ??
                                      '_',
                              value: controller
                                      .projectsList[index].assignedEngineer ??
                                  '_',
                              titleTextStyle: AppTextStyle.blackFontSize16W700,
                              valueTextStyle: AppTextStyle.blackFontSize13W700,
                              boxHeight: Get.height * 0.06,
                              width: Get.width * 0.4,
                              borderColor: index % 2 == 1
                                  ? Colors.white
                                  : Colors.grey.shade200,
                            ),

                            // Text(controller.projectsList[index].projectName ?? '_'),
                            // Text(controller.projectsList[index].assignedEngineer ?? '_'),

                            PopupMenuButton<int>(
                              // padding: EdgeInsets.zero,
                              color: Colors.white,
                              iconColor: Colors.white,
                              child: const Icon(Icons.more_vert_outlined),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  onTap: () {
                                    controller.showDetailsBottomSheet(
                                        index: index);
                                  },
                                  child: Text("View".tr),
                                ),
                                const PopupMenuDivider(),
                                PopupMenuItem(
                                  onTap: () {
                                    controller.startDateTextController.text =
                                        controller.projectsList[index]
                                                .startDate ??
                                            '';
                                    controller.endDateTextController.text =
                                        controller
                                                .projectsList[index].endDate ??
                                            '';
                                    controller.startDayTextController.text =
                                        controller.projectsList[index]
                                                .startDayOfYear
                                                .toString() ??
                                            '';
                                    controller.endDayTextController.text =
                                        controller.projectsList[index]
                                                .endDayOfYear
                                                .toString() ??
                                            '';
                                    controller.projectNameTextController.text =
                                        controller.projectsList[index]
                                                .projectName ??
                                            '';
                                    controller.projectUpdateTextController
                                        .text = controller.projectsList[index]
                                            .projectUpdate ??
                                        '';
                                    controller.engineerTextController.text =
                                        controller.projectsList[index]
                                                .assignedEngineer ??
                                            '';
                                    controller.technicianTextController.text =
                                        controller.projectsList[index]
                                                .assignedTechnician ??
                                            '';
                                    controller.durationTextController.text =
                                        controller.projectsList[index].duration
                                                .toString() ??
                                            '';

                                    controller.editInfoBottomSheet(
                                        index: index);
                                  },
                                  child: Text("Update".tr),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    } else if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return const Center(
                          child: Text(
                        'No data available',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ));
                    }
                  },
                  controller: controller.scrollController,
                ),
              ),
            ],
          )),
    );
  }
}
