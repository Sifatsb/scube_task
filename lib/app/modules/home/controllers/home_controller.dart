import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:scube_task/app/data/constants/app_colors.dart';
import 'package:scube_task/app/data/constants/app_text_style.dart';
import 'package:scube_task/app/modules/home/views/widgets/bottom_sheet_tile.dart';
import 'package:scube_task/app/modules/home/views/widgets/bottom_tile_with_field.dart';
import 'package:scube_task/app/utilities/common_widgets/default_bottom_sheet_shape.dart';
import 'package:scube_task/app/utilities/common_widgets/primary_button.dart';
import 'package:scube_task/app/utilities/datepicker_dialogue/date_picker.dart';
import 'package:scube_task/app/utilities/extensions/widget.extensions.dart';
import 'package:scube_task/app/utilities/message/snack_bars.dart';
import 'package:scube_task/domain/core/model/all_project_response_model.dart';

class HomeController extends GetxController {
  RxList<AllProjectResponseModel> projectsList =
      <AllProjectResponseModel>[].obs;

  RxBool isLoading = false.obs;
  RxBool updateInfoLoader = false.obs;
  RxInt offset = 0.obs;
  RxInt limit = 10.obs;
  RxString startDate = 'Select Date'.obs;
  RxString endDate = 'Select Date'.obs;

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

  Future<AllProjectResponseModel> updateInfo(
      {required int projectId, required int index}) async {
    updateInfoLoader.value = true;
    try {
      final response = await http.put(
          Uri.parse(
              'https://scubetech.xyz/projects/dashboard/update-project-elements/$projectId/'),
          body: {
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

        startDateTextController.clear();
        endDateTextController.clear();
        startDayTextController.clear();
        endDayTextController.clear();
        projectNameTextController.clear();
        projectUpdateTextController.clear();
        engineerTextController.clear();
        technicianTextController.clear();
        durationTextController.clear();

        Get.back();
        showBasicSuccessSnackBar(
            message: 'Updated Successfully', positionTop: true);
      } else {
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


  Future<AllProjectResponseModel> addInfo() async {
    updateInfoLoader.value = true;
    try {
      final response = await http.post(
          Uri.parse(
              'https://scubetech.xyz/projects/dashboard/add-project-elements/'),
          body: {
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
      debugPrint('Response ::: ${response.statusCode}');

      if (response.statusCode >= 200 || response.statusCode <= 207) {
        updateInfoLoader.value = false;

        startDateTextController.clear();
        endDateTextController.clear();
        startDayTextController.clear();
        endDayTextController.clear();
        projectNameTextController.clear();
        projectUpdateTextController.clear();
        engineerTextController.clear();
        technicianTextController.clear();
        durationTextController.clear();

        Get.back();
        showBasicSuccessSnackBar(
            message: 'Project element created successfully', positionTop: true);
      } else {
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

  void _pickStartDate() async {
    DateTime? dateTime = await DatePickerUtils().pickDate(
      canSelectPastDate: true,
      canSelectFutureDate: true,
    );

    if (dateTime != null) {
      startDateTextController.text = dateTime.yyyy_mm_dd;
      startDate.value = startDateTextController.text;
    }
  }

  void _pickEndDate() async {
    DateTime? dateTime = await DatePickerUtils().pickDate(
      canSelectPastDate: true,
      canSelectFutureDate: true,
    );

    if (dateTime != null) {
      endDateTextController.text = dateTime.yyyy_mm_dd;
      endDate.value = endDateTextController.text;
    }
  }



  void showDetailsBottomSheet({required int index}) {
    Get.bottomSheet(
      SizedBox(
          height: Get.height * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpacing,
              const Padding(
                padding: EdgeInsets.all(17.0),
                child: Text(
                  'Project Info',
                  style: AppTextStyle.blackFontSize13W700,
                ),
              ),
              BottomSheetTile(
                title: "Project",
                value: projectsList[index].projectName,
                color: AppColors.ofWhiteColor,
                width: 141,
              ),
              BottomSheetTile(
                title: "Engineer",
                value: projectsList[index].assignedEngineer,
                color: Colors.white,
                width: 141,
              ),
              BottomSheetTile(
                title: "Technician",
                value: projectsList[index].assignedTechnician,
                color: AppColors.ofWhiteColor,
                width: 141,
              ),
              BottomSheetTile(
                title: "Project Update",
                value: projectsList[index].projectUpdate,
                color: Colors.white,
                width: 141,
              ),
              BottomSheetTile(
                title: "Duration",
                value: projectsList[index].duration.toString(),
                color: AppColors.ofWhiteColor,
                width: 141,
              ),
              BottomSheetTile(
                title: "Start Day",
                value: projectsList[index].startDayOfYear.toString(),
                color: Colors.white,
                width: 141,
              ),
              BottomSheetTile(
                title: "End Day",
                value: projectsList[index].endDayOfYear.toString(),
                color: AppColors.ofWhiteColor,
                width: 141,
              ),
              BottomSheetTile(
                title: "Start Date",
                value: projectsList[index].startDate,
                color: Colors.white,
                width: 141,
              ),
              BottomSheetTile(
                title: "End Date",
                value: projectsList[index].endDate,
                color: AppColors.ofWhiteColor,
                width: 141,
              ),
            ],
          )),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
      isScrollControlled: true,
    );
  }

  void editInfoBottomSheet({required int index}) {
    Get.bottomSheet(
      SizedBox(
          height: Get.height * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpacing,
              const Padding(
                padding: EdgeInsets.all(17.0),
                child: Text(
                  'Edit Info',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                      color: Color(0xFF635976)),
                ),
              ),
              CustomTextFieldWithTile(
                title: 'Start Date',
                controller: startDateTextController,
                hintTex: 'Start Date...',
                color: Colors.white,
              ),
              CustomTextFieldWithTile(
                  title: 'End Date',
                  controller: endDateTextController,
                  hintTex: 'End Date...',
                  color: AppColors.ofWhiteColor),
              CustomTextFieldWithTile(
                title: 'Start Day',
                controller: startDayTextController,
                hintTex: 'Start Day...',
                color: Colors.white,
              ),
              CustomTextFieldWithTile(
                title: 'End Day',
                controller: endDayTextController,
                hintTex: 'End Day...',
                color: AppColors.ofWhiteColor,
              ),
              CustomTextFieldWithTile(
                title: 'Project Name',
                controller: projectNameTextController,
                hintTex: 'Project Name...',
                color: Colors.white,
              ),
              CustomTextFieldWithTile(
                  title: 'Project Update',
                  controller: projectUpdateTextController,
                  hintTex: 'Project Update...',
                  color: AppColors.ofWhiteColor),
              CustomTextFieldWithTile(
                title: 'Engineer',
                controller: engineerTextController,
                hintTex: 'Engineer...',
                color: Colors.white,
              ),
              CustomTextFieldWithTile(
                title: 'Technician',
                controller: technicianTextController,
                hintTex: 'Technician...',
                color: AppColors.ofWhiteColor,
              ),
              CustomTextFieldWithTile(
                title: 'Duration',
                controller: durationTextController,
                hintTex: 'Duration...',
                color: Colors.white,
              ),
              const Spacer(),
              Obx(() => updateInfoLoader.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(
                      child: PrimaryButton(
                        text: 'Update',
                        width: Get.width / 2.5,
                        color: Colors.green,
                        borderRadius: 5,
                        onTap: () {
                          updateInfo(
                              projectId: projectsList[index].id!, index: index);
                        },
                      ),
                    )),
              31.verticalSpacing,
            ],
          )),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
      isScrollControlled: true,
    );
  }

  void addInfoBottomSheet() {
    Get.bottomSheet(
      SizedBox(
          height: Get.height * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpacing,
              const Padding(
                padding: EdgeInsets.all(17.0),
                child: Text(
                  'Edit Info',
                  style: AppTextStyle.blackFontSize13W700,
                ),
              ),
              Obx(() => CustomTextFieldWithTile(
                title: 'Start Date',
                controller: startDateTextController,
                hintTex: startDate.value,
                color: Colors.white,
                readOnly: true,
                iconOnTap: _pickStartDate,
              )),
              Obx(() => CustomTextFieldWithTile(
                title: 'End Date',
                controller: endDateTextController,
                hintTex: endDate.value,
                color: AppColors.ofWhiteColor,
                readOnly: true,
                iconOnTap: _pickEndDate,
              )),
              CustomTextFieldWithTile(
                title: 'Start Day',
                controller: startDayTextController,
                hintTex: 'Start Day...',
                color: Colors.white,
                keyboardType: TextInputType.number,
              ),
              CustomTextFieldWithTile(
                title: 'End Day',
                controller: endDayTextController,
                hintTex: 'End Day...',
                color: AppColors.ofWhiteColor,
                keyboardType: TextInputType.number,
              ),
              CustomTextFieldWithTile(
                title: 'Project Name',
                controller: projectNameTextController,
                hintTex: 'Project Name...',
                color: Colors.white,
              ),
              CustomTextFieldWithTile(
                  title: 'Project Update',
                  controller: projectUpdateTextController,
                  hintTex: 'Project Update...',
                  color: AppColors.ofWhiteColor),
              CustomTextFieldWithTile(
                title: 'Engineer',
                controller: engineerTextController,
                hintTex: 'Engineer...',
                color: Colors.white,
              ),
              CustomTextFieldWithTile(
                title: 'Technician',
                controller: technicianTextController,
                hintTex: 'Technician...',
                color: AppColors.ofWhiteColor,
              ),
              CustomTextFieldWithTile(
                title: 'Duration',
                controller: durationTextController,
                hintTex: 'Duration...',
                color: Colors.white,
                keyboardType: TextInputType.number,
              ),
              const Spacer(),
              Obx(() => updateInfoLoader.value
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : Center(
                child: PrimaryButton(
                  text: 'Add',
                  width: Get.width / 2.5,
                  color: Colors.green,
                  borderRadius: 5,
                  onTap: () {
                    addInfo();
                  },
                ),
              )),
              31.verticalSpacing,
            ],
          )),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
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
