import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/sign_in/controller/sign_in_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
  }
}
