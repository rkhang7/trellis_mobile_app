import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/board/board_response.dart';
import 'package:trellis_mobile_app/models/user/user_request.dart';
import 'package:trellis_mobile_app/models/user/user_response.dart';
import 'package:trellis_mobile_app/models/workspace/workspace_response.dart';
import 'package:trellis_mobile_app/repository/board_repository.dart';
import 'package:trellis_mobile_app/repository/user_repository.dart';
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
  final userRepository = Get.find<UserRepository>();

  var listWorkspace = <WorkSpaceResponse>[].obs;

  var isVisibleWorkspace = false.obs;

  final currentId = FirebaseAuth.instance.currentUser!.uid;

  var listBoards = <BoardResponse>[].obs;

  var boardIdSelected = -1;

  var currentUser = UserResponse(
    uid: "",
    email: "email",
    first_name: "first_name",
    last_name: "last_name",
    avatar_background_color: "avatar_background_color",
    avatar_url: "avatar_url",
    created_time: 1,
    updated_time: 2,
    token: "",
  ).obs;

  @override
  void onInit() {
    initUser();
    updateToken();
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
        .getListBoardsInWorkspace(workspaceId, currentId, "")
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

  Future refresh() async {
    loadListBoards(workspaceSelected.value.workspace_id);
  }

  void updateToken() async {
    FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      userRepository.getUserById(currentId).then(
        (value) {
          UserRequest userRequest = UserRequest(
            uid: currentId,
            email: value.email,
            firstName: value.first_name,
            lastName: value.last_name,
            avatarBackgroundColor: value.avatar_background_color,
            avatarURL: value.avatar_url,
            token: token,
          );
          userRepository.updateUser(currentId, userRequest);
        },
      );
    });
  }

  void initUser() async {}
}
