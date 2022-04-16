import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/board/invite_board_member/controller/invite_board_member_controller.dart';

class InviteBoardMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InviteBoardMemberController());
  }
}
