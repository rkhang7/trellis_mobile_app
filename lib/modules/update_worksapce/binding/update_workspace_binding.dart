import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/update_worksapce/controller/update_workspace_controller.dart';

class UpdateWorkSpaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateWorkspaceController());
  }
}
