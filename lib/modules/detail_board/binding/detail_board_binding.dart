import 'package:get/get.dart';

import '../controller/detail_board_controller.dart';

class DetailBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailBoardController());
  }
}
