import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/member/member_detail_response.dart';
import 'package:trellis_mobile_app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:trellis_mobile_app/modules/workspace_menu/controller/workspace_menu_controller.dart';

class RemoveMemberController extends GetxController {
  final workspaceMenuController = Get.find<WorkspaceMenuController>();
  final dashBoardController = Get.find<DashBoardController>();

  var listMember = <MemberDetailResponse>[];

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
}
