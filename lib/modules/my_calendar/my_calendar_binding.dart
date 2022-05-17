import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/my_calendar/my_calendar_controller.dart';

class MyCalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyCalendarController());
  }
}
