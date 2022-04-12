import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/member/member_request.dart';
import 'package:trellis_mobile_app/models/workspace/workspace_request.dart';
import 'package:trellis_mobile_app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:trellis_mobile_app/repository/member_repository.dart';
import 'package:trellis_mobile_app/repository/workspace_repository.dart';

class CreateWorkspaceController extends GetxController {
  var workspaceNameController = TextEditingController();
  var workspaceNameIsEmpty = true.obs;
  var descriptionController = TextEditingController();
  var selectedType = "select".obs;
  var workspaceRepository = Get.find<WorkspaceRepository>();
  var memberRepository = Get.find<MemberRepository>();
  var dashboardController = Get.find<DashBoardController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void createWorkspace(WorkSpaceRequest workSpaceRequest) {
    EasyLoading.show(status: "please_wait".tr);
    workspaceRepository.createWorkspace(workSpaceRequest).then((value) {
      dashboardController.listWorkspace.add(value);

      dashboardController.workspaceSelected.value =
          dashboardController.listWorkspace[0];
      dashboardController.checkVisible();

      // assign admin
      memberRepository
          .createMemberIntoWorkspace(
        MemberRequest(
            memberId: dashboardController.currentId,
            permission: 1,
            workspaceId: value.workspace_id),
      )
          .then(
        (value) {
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }

          EasyLoading.showSuccess("create_success".tr);

          Get.back();
        },
      );
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }

          EasyLoading.showError("error".tr);
          break;
        default:
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }

          EasyLoading.showError("error".tr);
          break;
      }
    });
  }
}
