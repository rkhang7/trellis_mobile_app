import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/search_board/controller/search_board_controller.dart';

class SearchBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchBoardController());
  }
}
