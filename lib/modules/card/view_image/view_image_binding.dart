import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/card/view_image/view_image_controller.dart';

class ViewImageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewImageController());
  }
}
