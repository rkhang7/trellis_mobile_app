import 'package:get/get.dart';

import 'update_workspace_controller.dart';

class UpdateWorkSpaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateWorkspaceController());
  }
}
