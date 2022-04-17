import 'package:get/get.dart';

import 'remove_member_controller.dart';

class RemoveMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RemoveMemberController());
  }
}
