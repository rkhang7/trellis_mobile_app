import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/workspace/workspace_response.dart';
import 'package:trellis_mobile_app/repository/workspace_repository.dart';

class CreateBoardController extends GetxController {
  var boardNameController = TextEditingController();
  final listWorkSpaces = Rx<List<WorkSpaceResponse>>([]);
  var selectedWorkspaceId = 0.obs;
  final listDropdownMenuItemWorkspaces = Rx<List<DropdownMenuItem<String>>>([]);
  final boardNameIsEmpty = true.obs;
  final workspaceRepository = Get.find<WorkspaceRepository>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getListWorkspaces();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void getListWorkspaces() async {
    try {
      // Get.dialog(
      //   const Center(
      //     child: CircularProgressIndicator(),
      //   ),
      // );

      // get data from api

      await workspaceRepository
          .getWorkspacesByUid(FirebaseAuth.instance.currentUser!.uid)
          .then((value) {
        listWorkSpaces.value.assignAll(value);
        if (value.isNotEmpty) {
          selectedWorkspaceId.value = value[0].workspace_id;
        }
      });

      for (WorkSpaceResponse workspace in listWorkSpaces.value) {
        listDropdownMenuItemWorkspaces.value.add(
          DropdownMenuItem(
            child: ListTile(
              title: Text(workspace.name),
              leading: const Icon(Icons.group_outlined),
            ),
            value: workspace.workspace_id.toString(),
          ),
        );
      }
    } catch (ex) {
      Get.back();
    }
  }

  WorkSpaceResponse? findWorkspaceById(int id) {
    for (WorkSpaceResponse workspace in listWorkSpaces.value) {
      if (workspace.workspace_id == id) {
        return workspace;
      }
    }
    return null;
  }
}
