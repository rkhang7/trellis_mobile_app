import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/create_board/controller/create_board_controller.dart';
import 'package:trellis_mobile_app/modules/create_workspace/controller/create_workspace_controller.dart';

class CreateWorkspaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateWorkspaceController());
  }
}
