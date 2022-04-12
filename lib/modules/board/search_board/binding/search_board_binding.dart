import 'package:get/get.dart';

import '../controller/search_board_controller.dart';

class SearchBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchBoardController());
  }
}
