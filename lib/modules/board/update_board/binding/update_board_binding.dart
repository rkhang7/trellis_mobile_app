import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/board/update_board/controller/update_board_controller.dart';

class UpdateBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateBoardController());
  }
}
