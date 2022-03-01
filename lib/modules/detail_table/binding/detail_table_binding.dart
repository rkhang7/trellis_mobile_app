import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/detail_table/controller/detail_board_controller.dart';

class DetailBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailBoardController());
  }
}
