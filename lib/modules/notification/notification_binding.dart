import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/notification/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationController());
  }
}
