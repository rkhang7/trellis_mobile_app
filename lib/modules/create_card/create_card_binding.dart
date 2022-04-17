import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/create_card/create_card_controller.dart';

class CreateCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateCardController());
  }
}
