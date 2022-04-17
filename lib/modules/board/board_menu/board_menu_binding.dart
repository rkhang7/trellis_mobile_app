import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/board/board_menu/board_menu_controller.dart';

class BoardMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BoardMenuController());
  }
}
