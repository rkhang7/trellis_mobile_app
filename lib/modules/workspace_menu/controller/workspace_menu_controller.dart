import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/member/member_response.dart';
import 'package:trellis_mobile_app/models/user/user_response.dart';
import 'package:trellis_mobile_app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:trellis_mobile_app/repository/member_repository.dart';
import 'package:trellis_mobile_app/repository/user_repository.dart';

class WorkspaceMenuController extends GetxController {
  var memberRepository = Get.find<MemberRepository>();
  var userRepository = Get.find<UserRepository>();
  var dashboardController = Get.find<DashBoardController>();

  var listMember = <MemberResponse>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    initListMember();
    super.onInit();
  }

  void initListMember() {
    int workspaceId = dashboardController.workspaceSelected.value.workspace_id;
    memberRepository.getListMemberInWorkspace(workspaceId).then((value) {
      listMember.assignAll(value);
    });
  }
}
