import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/workspace_menu/controller/workspace_menu_controller.dart';

class WorkspaceMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WorkspaceMenuController());
  }
}
