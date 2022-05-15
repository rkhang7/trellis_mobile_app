import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/statistics/statistics_controller.dart';

class StatisticsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StatisticsController());
  }
}
