import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/dashboard/controller/dashboard_controller.dart';

class UpdateWorkspaceController extends GetxController {
  var workspaceNameController = TextEditingController();
  var descriptionController = TextEditingController();
  var workspaceNameIsEmpty = false.obs;
  var selectedType = "select".obs;

  final dashBoardController = Get.find<DashBoardController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initData();
  }

  void initData() {
    workspaceNameController.text =
        dashBoardController.workspaceSelected.value.name;
    descriptionController.text =
        dashBoardController.workspaceSelected.value.description;
    selectedType.value =
        dashBoardController.workspaceSelected.value.workspace_type;
  }
}
