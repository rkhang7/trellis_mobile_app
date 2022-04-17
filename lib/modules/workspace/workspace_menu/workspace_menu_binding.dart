import 'package:get/get.dart';

import 'workspace_menu_controller.dart';

class WorkspaceMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WorkspaceMenuController());
  }
}
