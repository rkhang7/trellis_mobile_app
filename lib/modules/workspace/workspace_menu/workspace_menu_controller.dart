import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/member/member_detail_response.dart';
import 'package:trellis_mobile_app/modules/dashboard/dashboard_controller.dart';
import 'package:trellis_mobile_app/repository/member_repository.dart';
import 'package:trellis_mobile_app/repository/user_repository.dart';
import 'package:trellis_mobile_app/repository/workspace_repository.dart';

class WorkspaceMenuController extends GetxController {
  var memberRepository = Get.find<MemberRepository>();
  var userRepository = Get.find<UserRepository>();
  var dashboardController = Get.find<DashBoardController>();
  var workspaceRepository = Get.find<WorkspaceRepository>();

  var listMember = <MemberDetailResponse>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    initListMember();
    super.onInit();
  }

  void initListMember() {
    int workspaceId = dashboardController.workspaceSelected.value.workspaceId;
    memberRepository.getListMemberInWorkspace(workspaceId).then((value) {
      listMember.addAll(value);
    });
  }

  int getPermissionForCurrentUser() {
    for (MemberDetailResponse memberDetailResponse in listMember) {
      if (dashboardController.currentId == memberDetailResponse.memberId) {
        return memberDetailResponse.permission;
      }
    }
    return -1;
  }

  void deleteWorkspace() async {
    EasyLoading.show(status: "please_wait".tr);
    workspaceRepository
        .deleteWorkspace(
            dashboardController.workspaceSelected.value.workspaceId)
        .then(
      (value) async {
        EasyLoading.dismiss();
        dashboardController.initWorkspace();
        Get.back();
      },
    ).catchError((Object obj) {
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
