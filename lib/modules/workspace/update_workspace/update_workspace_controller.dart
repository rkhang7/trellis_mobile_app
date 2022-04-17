import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/workspace/workspace_request.dart';
import 'package:trellis_mobile_app/modules/dashboard/dashboard_controller.dart';
import 'package:trellis_mobile_app/repository/workspace_repository.dart';

class UpdateWorkspaceController extends GetxController {
  var workspaceNameController = TextEditingController();
  var descriptionController = TextEditingController();
  var workspaceNameIsEmpty = false.obs;
  var selectedType = "select".obs;

  final dashBoardController = Get.find<DashBoardController>();
  var workspaceRepository = Get.find<WorkspaceRepository>();

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

  void updateWorkspace() {
    EasyLoading.show(status: "update_success".tr);
    int workspaceId = dashBoardController.workspaceSelected.value.workspace_id;
    workspaceRepository
        .updateWorkspace(
            workspaceId,
            WorkSpaceRequest(
                name: workspaceNameController.text.trim(),
                workspaceType: selectedType.value,
                description: descriptionController.text,
                closed: false,
                createdBy: dashBoardController.currentId))
        .then((value) {
      dashBoardController.workspaceSelected.value.name = value.name;
      dashBoardController.workspaceSelected.value.workspace_type = value.name;
      dashBoardController.workspaceSelected.value.description =
          value.description;
      EasyLoading.dismiss();

      EasyLoading.showSuccess("update_success".tr);
      Get.back();
      Get.back();
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          EasyLoading.dismiss();

          EasyLoading.showError("error".tr);
          break;
        default:
          EasyLoading.dismiss();

          EasyLoading.showError("error".tr);
          break;
      }
    });
  }
}
