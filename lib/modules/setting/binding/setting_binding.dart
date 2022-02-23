import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/setting/controller/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingController());
  }
}
