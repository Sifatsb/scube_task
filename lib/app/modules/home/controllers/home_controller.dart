import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:scube_task/app/data/constants/app_colors.dart';
import 'package:scube_task/app/utilities/common_widgets/custom_text_field.dart';
import 'package:scube_task/app/utilities/common_widgets/primary_button.dart';
import 'package:scube_task/app/utilities/extensions/widget.extensions.dart';
import 'package:scube_task/app/utilities/message/snack_bars.dart';
import 'package:scube_task/domain/core/model/all_project_response_model.dart';

class HomeController extends GetxController {
  RxList<AllProjectResponseModel> projectsList = <AllProjectResponseModel>[].obs;

  RxBool isLoading = false.obs;
  RxBool updateInfoLoader = false.obs;
  RxInt offset = 0.obs;
  RxInt limit = 10.obs;

  TextEditingController startDateTextController = TextEditingController();
  TextEditingController endDateTextController = TextEditingController();
  TextEditingController startDayTextController = TextEditingController();
  TextEditingController endDayTextController = TextEditingController();
  TextEditingController projectNameTextController = TextEditingController();
  TextEditingController projectUpdateTextController = TextEditingController();
  TextEditingController engineerTextController = TextEditingController();
  TextEditingController technicianTextController = TextEditingController();
  TextEditingController durationTextController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      fetchProjects();
    }
  }

  Future<void> fetchProjects() async {
    if (isLoading.value) return;

    isLoading.value = true;

    try {
      final response = await http.get(Uri.parse(
          'https://scubetech.xyz/projects/dashboard/all-project-elements/?offset=${offset.value}&limit=${limit.value}'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        List<AllProjectResponseModel> newProjects = jsonResponse
            .map((json) => AllProjectResponseModel.fromJson(json))
            .toList();

        projectsList.addAll(newProjects);
        isLoading.value = false;
        offset.value += newProjects.length;
      } else {
        throw Exception('Failed to load projects');
      }
    } catch (e, t) {
      showBasicFailedSnackBar(message: 'Something went wrong');
      debugPrint('Error fetching projects: $e');
      debugPrint('Error fetching projects: $t');
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<AllProjectResponseModel> updateInfo({required int projectId, required int index}) async {

    updateInfoLoader.value = true;
    try {
      
      final response = await http.put(Uri.parse('https://scubetech.xyz/projects/dashboard/update-project-elements/$projectId/'), body: {
        "start_date": startDateTextController.text,
        "end_date": endDateTextController.text,
        "project_name": projectNameTextController.text,
        "project_update": projectUpdateTextController.text,
        "assigned_engineer": engineerTextController.text,
        "assigned_technician": technicianTextController.text,
        "start_day_of_year": startDayTextController.text,
        "end_day_of_year": endDayTextController.text,
        "duration": durationTextController.text,
      });

      debugPrint('Response ::: ${response.body}');

      if (response.statusCode == 200) {
        updateInfoLoader.value = false;
        final jsonResponse = json.decode(response.body);
        final updatedProject = AllProjectResponseModel.fromJson(jsonResponse);

        projectsList[index] = updatedProject;
        projectsList.refresh();
        Get.back();
      }
      else {
        updateInfoLoader.value = false;
        showBasicFailedSnackBar(message: 'Something went wrong.');
      }


    } catch (e, t) {
      debugPrint('Error fetching projects: $e');
      debugPrint('Error fetching projects: $t');
      updateInfoLoader.value = false;
    } finally {
      updateInfoLoader.value = false;
    }

    return AllProjectResponseModel();

  }

  void showDetailsBottomSheet({required int index}) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.45,
        width: Get.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
          ),
          color: AppColors.secondaryColor,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Project:   ${projectsList[index].projectName}',
                ),
                Text(
                  'Engineer:  ${projectsList[index].assignedEngineer}',
                ),
                Text(
                  'Technician:  ${projectsList[index].assignedTechnician}',
                ),
                Text(
                  'Project Update:  ${projectsList[index].projectUpdate}',
                ),
                Text(
                  'Duration:  ${projectsList[index].duration}',
                ),
                Text(
                  'Start Day:   ${projectsList[index].startDayOfYear}',
                ),
                Text(
                  'End Day:   ${projectsList[index].endDayOfYear}',
                ),
                Text(
                  'Start Date:  ${projectsList[index].startDate}',
                ),
                Text(
                  'End Date:  ${projectsList[index].endDate}',
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            8,
          ),
          topRight: Radius.circular(
            8,
          ),
        ),
      ),
      isDismissible: true,
    );
  }


  void editInfoBottomSheet({required int index}) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.7,
        width: Get.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
          ),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                CustomTextField(tile: 'Start Date', controller: startDateTextController,),
                CustomTextField(tile: 'End Date', controller: endDateTextController,),
                CustomTextField(tile: 'Start Day', controller: startDayTextController,),
                CustomTextField(tile: 'End Day', controller: endDayTextController,),
                CustomTextField(tile: 'Project Name', controller: projectNameTextController,),
                CustomTextField(tile: 'Project Update', controller: projectUpdateTextController,),
                CustomTextField(tile: 'Engineer', controller: engineerTextController,),
                CustomTextField(tile: 'Technician', controller: technicianTextController,),
                CustomTextField(tile: 'Duration', controller: durationTextController,),
                
                30.verticalSpacing,
                
                Obx(() => updateInfoLoader.value ? const Center(child: CircularProgressIndicator(),) : PrimaryButton(text: 'Update', color: Colors.green, borderRadius: 5,
                  onTap: (){
                    updateInfo(projectId: projectsList[index].id!, index: index);
                  },
                )),

              ],
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            8,
          ),
          topRight: Radius.circular(
            8,
          ),
        ),
      ),
      isDismissible: true,
      isScrollControlled: true,

    );
  }

  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
    fetchProjects();
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
