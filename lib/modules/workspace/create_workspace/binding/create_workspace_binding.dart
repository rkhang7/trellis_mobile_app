import 'package:get/get.dart';

import '../controller/create_workspace_controller.dart';

class CreateWorkspaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CreateWorkspaceController(),
    );
  }
}
