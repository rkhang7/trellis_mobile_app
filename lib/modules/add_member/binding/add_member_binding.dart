import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/add_member/controller/add_member_controller.dart';

class AddMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddMemberController());
  }
}
