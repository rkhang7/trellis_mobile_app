import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/board/update_board/update_board_controller.dart';
import 'package:trellis_mobile_app/modules/card/update_card/update_card_controller.dart';

class UpdateCardBiding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateCardController());
  }
}
