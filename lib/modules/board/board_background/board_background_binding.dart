import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/board/board_background/board_background_controller.dart';

class BoardBackgroundBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BoardBackgroundController());
  }
}
