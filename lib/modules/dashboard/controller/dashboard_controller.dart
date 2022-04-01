import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/workspace/workspace_response.dart';
import 'package:trellis_mobile_app/repository/workspace_repository.dart';

class DashBoardController extends GetxController {
  var workspaceSelected = WorkSpaceResponse(
          workspace_id: -1,
          name: "name",
          workspace_type: "workspace_type",
          description: "description",
          created_time: 1,
          updated_time: 1,
          created_by: "!")
      .obs;
  var workspaceRepository = Get.find<WorkspaceRepository>();

  var listWorkspace = <WorkSpaceResponse>[].obs;

  var isVisibleWorkspace = false.obs;

  final currentId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    initWorkspace();
  }

  void initWorkspace() async {
    await workspaceRepository
        .getWorkspacesByUid(FirebaseAuth.instance.currentUser!.uid)
        .then((workspaces) {
      if (workspaces.isNotEmpty) {
        listWorkspace.assignAll(workspaces);
        workspaceSelected.value = workspaces.elementAt(0);
        log(workspaceSelected.value.name);
      }
      checkVisible();
    });
  }

  void checkVisible() {
    if (listWorkspace.isEmpty) {
      isVisibleWorkspace.value = false;
    } else {
      isVisibleWorkspace.value = true;
    }
  }
}
