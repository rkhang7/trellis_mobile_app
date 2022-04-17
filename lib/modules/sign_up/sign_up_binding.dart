import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/sign_up/sign_up_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }
}
