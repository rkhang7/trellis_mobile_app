import 'package:get/get.dart';

import '../controller/invite_member_controller.dart';

class InviteMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InviteMemberController());
  }
}
