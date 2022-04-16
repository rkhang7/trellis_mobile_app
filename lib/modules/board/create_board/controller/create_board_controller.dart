import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/board/board_request.dart';
import 'package:trellis_mobile_app/models/workspace/workspace_response.dart';
import 'package:trellis_mobile_app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:trellis_mobile_app/repository/board_repository.dart';
import 'package:trellis_mobile_app/repository/workspace_repository.dart';

class CreateBoardController extends GetxController {
  var boardNameController = TextEditingController();
  final listWorkSpaces = Rx<List<WorkSpaceResponse>>([]);
  var selectedWorkspaceId = 0.obs;
  final listDropdownMenuItemWorkspaces = Rx<List<DropdownMenuItem<String>>>([]);
  final boardNameIsEmpty = true.obs;
  final workspaceRepository = Get.find<WorkspaceRepository>();
  final boardRepository = Get.find<BoardRepository>();
  final dashBoardController = Get.find<DashBoardController>();
  var selectType = 1.obs;

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

  void createBoard() {
    EasyLoading.show(status: "please_wait".tr);
    String boardName = boardNameController.text;
    var boardRequest = BoardRequest(
        name: boardName,
        description: "",
        closed: false,
        visibility: selectType.value,
        workspaceId: selectedWorkspaceId.value,
        createdBy: dashBoardController.currentId);

    boardRepository.createBoard(boardRequest).then((value) {
      EasyLoading.dismiss();

      EasyLoading.showSuccess("create_success".tr);

      // insert to first index list workspace
      dashBoardController.listBoards.insert(0, value);

      Get.back();
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          EasyLoading.dismiss();

          EasyLoading.showError("error".tr);
          break;
        default:
          EasyLoading.dismiss();

          EasyLoading.showError("error".tr);
          break;
      }
    });
  }
}
