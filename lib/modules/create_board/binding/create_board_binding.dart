import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/create_board/controller/create_board_controller.dart';

class CreateBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateBoardController());
  }
}
