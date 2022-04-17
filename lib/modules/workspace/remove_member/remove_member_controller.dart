import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/member/member_detail_response.dart';
import 'package:trellis_mobile_app/modules/dashboard/dashboard_controller.dart';
import 'package:trellis_mobile_app/repository/member_repository.dart';

import '../workspace_menu/workspace_menu_controller.dart';

class RemoveMemberController extends GetxController {
  final workspaceMenuController = Get.find<WorkspaceMenuController>();
  final dashBoardController = Get.find<DashBoardController>();
  final memberRepository = Get.find<MemberRepository>();

  var listMember = <MemberDetailResponse>[].obs;

  @override
  void onInit() {
    listMember = workspaceMenuController.listMember;
    super.onInit();
  }

  int getPermissionForCurrentUser() {
    for (MemberDetailResponse memberDetailResponse in listMember) {
      if (dashBoardController.currentId == memberDetailResponse.member_id) {
        return memberDetailResponse.permission;
      }
    }
    return -1;
  }

  void removeMemberFormWorkspace(String uid, int index) async {
    EasyLoading.show(status: "please_wait".tr);
    await memberRepository
        .removeMemberFromWorkspace(
            uid, dashBoardController.workspaceSelected.value.workspace_id)
        .then((value) {
      listMember.removeAt(index);
      EasyLoading.dismiss();
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

  void leaveWorkspace() async {
    EasyLoading.show(status: "please_wait".tr);
    await memberRepository
        .removeMemberFromWorkspace(dashBoardController.currentId,
            dashBoardController.workspaceSelected.value.workspace_id)
        .then((value) {
      EasyLoading.dismiss();
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
