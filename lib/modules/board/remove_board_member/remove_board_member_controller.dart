import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/member/board_member_detail_response.dart';
import 'package:trellis_mobile_app/modules/board/board_menu/board_menu_controller.dart';
import 'package:trellis_mobile_app/modules/dashboard/dashboard_controller.dart';

import '../../../repository/member_repository.dart';

class RemoveBoardMemberController extends GetxController {
  final boardMenuController = Get.find<BoardMenuController>();
  final dashBoardController = Get.find<DashBoardController>();
  final memberRepository = Get.find<MemberRepository>();
  var listMember = <BoardMemberDetailResponse>[].obs;

  @override
  void onInit() {
    listMember = boardMenuController.listMember;
    super.onInit();
  }

  int getPermissionForCurrentUser() {
    for (BoardMemberDetailResponse memberDetailResponse in listMember) {
      if (dashBoardController.currentId == memberDetailResponse.memberId) {
        return memberDetailResponse.permission;
      }
    }
    return -1;
  }

  void removeMemberFormBoard(String uid, int index) async {
    EasyLoading.show(status: "please_wait".tr);
    await memberRepository
        .removeMemberFromBoard(uid, dashBoardController.boardIdSelected)
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
            dashBoardController.workspaceSelected.value.workspaceId)
        .then((value) {
      EasyLoading.dismiss();
      Get.back();
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
