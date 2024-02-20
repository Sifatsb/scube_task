import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:scube_task/app/utilities/message/snack_bars.dart';
import 'package:scube_task/domain/core/model/all_project_response_model.dart';

class HomeController extends GetxController {
  List<AllProjectResponseModel> projects = [];

  // List<dynamic> projects = [];
  RxBool isLoading = false.obs;
  RxInt offset = 0.obs;
  RxInt limit = 10.obs; // Number of items to fetch per request

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

        projects.addAll(newProjects);
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
