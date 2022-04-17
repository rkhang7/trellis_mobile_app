import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/board/remove_board_member/remove_board_member_controller.dart';
import 'package:trellis_mobile_app/modules/workspace/remove_member/remove_member_controller.dart';

class RemoveBoardMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RemoveBoardMemberController());
  }
}
