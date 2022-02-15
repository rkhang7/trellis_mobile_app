import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/walk_through/controller/walk_through_controller.dart';

class WalkThroughBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WakThroughController());
  }
}
