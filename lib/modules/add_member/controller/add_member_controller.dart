import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/workspace/workspace_response.dart';

import '../../dashboard/controller/dashboard_controller.dart';

class AddMemberController extends GetxController {
  var dashboardController = Get.find<DashBoardController>();
  var emailController = TextEditingController();
  WorkSpaceResponse? currentWorkspace;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initData();
  }

  void initData() {
    currentWorkspace = dashboardController.workspaceSelected.value;
  }
}
