import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/remove_member/controller/remove_member_controller.dart';

class RemoveMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RemoveMemberController());
  }
}
