import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/core/board_model.dart';
import 'package:trellis_mobile_app/models/workspace/workspace_request.dart';
import 'package:trellis_mobile_app/repository/workspace_repository.dart';

class CreateWorkspaceController extends GetxController {
  var workspaceNameController = TextEditingController();
  var workspaceNameIsEmpty = true.obs;
  var descriptionController = TextEditingController();
  var selectedType = "select".obs;
  var workspaceRepository = WorkspaceRepository();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void createWorkspace(WorkSpaceRequest workSpaceRequest) {
    EasyLoading.show(status: "please_wait".tr);
    workspaceRepository.createWorkspace(workSpaceRequest).then((value) {
      EasyLoading.dismiss();
      EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
      EasyLoading.showSuccess("create_success".tr);
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
