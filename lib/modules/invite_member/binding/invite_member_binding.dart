import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/invite_member/controller/invite_member_controller.dart';

class InviteMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InviteMemberController());
  }
}
