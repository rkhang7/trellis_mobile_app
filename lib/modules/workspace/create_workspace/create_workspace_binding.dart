import 'package:get/get.dart';

import 'create_workspace_controller.dart';

class CreateWorkspaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CreateWorkspaceController(),
    );
  }
}
