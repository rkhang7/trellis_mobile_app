import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/card/my_card/my_card_controller.dart';

class MyCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyCardController());
  }
}
