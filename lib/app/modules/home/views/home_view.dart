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
                return ListTile(
                  title: Text('${controller.projects[index].projectName}'),
                  subtitle:
                      Text('${controller.projects[index].assignedEngineer}'),
                );
              } else if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Container();
              }
            },
            controller: controller.scrollController,
          )),
    );
  }
}
