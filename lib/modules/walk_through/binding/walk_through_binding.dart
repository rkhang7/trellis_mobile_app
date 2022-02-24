import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/walk_through/controller/walk_through_controller.dart';
import 'package:trellis_mobile_app/service/auth_service.dart';

class WalkThroughBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WakThroughController(), fenix: true);
    Get.lazyPut(() => AuthService(), fenix: true);
  }
}
