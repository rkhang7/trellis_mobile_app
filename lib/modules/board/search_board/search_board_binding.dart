import 'package:get/get.dart';

import 'search_board_controller.dart';

class SearchBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchBoardController());
  }
}
