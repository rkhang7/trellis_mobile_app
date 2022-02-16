import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/detail_table/controller/detail_table_controller.dart';

class DetailTableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailTableController());
  }
}
