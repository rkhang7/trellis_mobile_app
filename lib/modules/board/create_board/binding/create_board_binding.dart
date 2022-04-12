import 'package:get/get.dart';

import '../controller/create_board_controller.dart';

class CreateBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateBoardController());
  }
}
