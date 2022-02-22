import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/workspace_model.dart';

class CreateBoardController extends GetxController {
  var boardNameController = TextEditingController();
  final listWorkSpaceModels = Rx<List<WorkspaceModel>>([]);
  var selectedWorkspaceId = 1.obs;
  final listDropdownMenuItemWorkspaces = Rx<List<DropdownMenuItem<String>>>([]);
  final boardNameIsEmpty = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getListWorkspaces();
  }

  void getListWorkspaces() {
    try {
      // Get.dialog(
      //   const Center(
      //     child: CircularProgressIndicator(),
      //   ),
      // );

      // get data from api

      var listWorkspaceFromApi = [
        WorkspaceModel(id: 1, name: "Nhóm 1"),
        WorkspaceModel(id: 2, name: "Nhóm 2"),
        WorkspaceModel(id: 3, name: "Nhóm 3"),
        WorkspaceModel(id: 4, name: "Nhóm 4"),
      ];
      listWorkSpaceModels.value.clear();
      listWorkSpaceModels.value.addAll(listWorkspaceFromApi);
      listDropdownMenuItemWorkspaces.value = [];
      for (WorkspaceModel workspaceModel in listWorkSpaceModels.value) {
        listDropdownMenuItemWorkspaces.value.add(
          DropdownMenuItem(
            child: ListTile(
              title: Text(workspaceModel.name),
              leading: const Icon(Icons.group_outlined),
            ),
            value: workspaceModel.id.toString(),
          ),
        );
      }
    } catch (ex) {
      Get.back();
    }
  }

  WorkspaceModel? findWorkspaceById(int id) {
    for (WorkspaceModel workspaceModel in listWorkSpaceModels.value) {
      if (workspaceModel.id == id) {
        return workspaceModel;
      }
    }
    return null;
  }
}
