import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
          workspaceId: -1,
          name: "name",
          workspaceType: "workspace_type",
          description: "description",
          closed: false,
          createdTime: 1,
          updatedTime: 1,
          createdBy: "!")
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
    firstName: "first_name",
    lastName: "last_name",
    avatarBackgroundColor: "avatar_background_color",
    avatarURL: "avatar_url",
    createdTime: 1,
    updatedTime: 2,
    token: "",
  ).obs;

  @override
  void onInit() {
    initUser();
    updateToken();
    initWorkspace();
    loadListBoards(workspaceSelected.value.workspaceId);
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
      loadListBoards(workspaceSelected.value.workspaceId);
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
    EasyLoading.show(status: 'loading'.tr);
    await boardRepository
        .getListBoardsInWorkspace(workspaceId, currentId, "")
        .then((value) {
      listBoards.assignAll(value);
      EasyLoading.dismiss();
    });
  }

  int findIndexBoardById(int boardId) {
    return listBoards.indexWhere((element) => element.boardId == boardId);
  }

  BoardResponse? getBoardSelected() {
    for (BoardResponse boardResponse in listBoards) {
      if (boardResponse.boardId == boardIdSelected) {
        return boardResponse;
      }
    }
    return null;
  }

  Future refresh() async {
    loadListBoards(workspaceSelected.value.workspaceId);
  }

  void updateToken() async {
    FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      userRepository.getUserById(currentId).then(
        (value) {
          UserRequest userRequest = UserRequest(
            uid: currentId,
            email: value.email,
            firstName: value.firstName,
            lastName: value.lastName,
            avatarBackgroundColor: value.avatarBackgroundColor,
            avatarURL: value.avatarURL,
            token: token,
          );
          userRepository.updateUser(currentId, userRequest);
        },
      );
    });
  }

  void initUser() async {}
}
