import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/board/board_response.dart';
import 'package:trellis_mobile_app/models/workspace/workspace_response.dart';
import 'package:trellis_mobile_app/repository/board_repository.dart';
import 'package:trellis_mobile_app/repository/workspace_repository.dart';

class DashBoardController extends GetxController {
  var workspaceSelected = WorkSpaceResponse(
          workspace_id: -1,
          name: "name",
          workspace_type: "workspace_type",
          description: "description",
          closed: false,
          created_time: 1,
          updated_time: 1,
          created_by: "!")
      .obs;
  final workspaceRepository = Get.find<WorkspaceRepository>();
  final boardRepository = Get.find<BoardRepository>();

  var listWorkspace = <WorkSpaceResponse>[].obs;

  var isVisibleWorkspace = false.obs;

  final currentId = FirebaseAuth.instance.currentUser!.uid;

  var listBoards = <BoardResponse>[].obs;

  var boardIdSelected = -1;

  @override
  void onInit() {
    initWorkspace();
    loadListBoards(workspaceSelected.value.workspace_id);
    super.onInit();
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
      loadListBoards(workspaceSelected.value.workspace_id);
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

  void loadListBoards(int workspaceId) async {
    await boardRepository
        .getListBoardsInWorkspace(workspaceId, currentId)
        .then((value) {
      listBoards.assignAll(value);
    });
  }

  int findIndexBoardById(int boardId) {
    return listBoards.indexWhere((element) => element.board_id == boardId);
  }

  BoardResponse? getBoardSelected() {
    for (BoardResponse boardResponse in listBoards) {
      if (boardResponse.board_id == boardIdSelected) {
        return boardResponse;
      }
    }
    return null;
  }
}
