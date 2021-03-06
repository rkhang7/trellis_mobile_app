import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/dashboard/dashboard_controller.dart';

class DashBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashBoardController());
  }
}
