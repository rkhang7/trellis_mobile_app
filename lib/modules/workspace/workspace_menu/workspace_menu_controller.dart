import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/member/member_detail_response.dart';
import 'package:trellis_mobile_app/modules/dashboard/dashboard_controller.dart';
import 'package:trellis_mobile_app/repository/member_repository.dart';
import 'package:trellis_mobile_app/repository/user_repository.dart';

class WorkspaceMenuController extends GetxController {
  var memberRepository = Get.find<MemberRepository>();
  var userRepository = Get.find<UserRepository>();
  var dashboardController = Get.find<DashBoardController>();

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
}
