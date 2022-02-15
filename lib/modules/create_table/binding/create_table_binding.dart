import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/create_table/controller/create_table_controller.dart';

class CreateTableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateTableController());
  }
}
