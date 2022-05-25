import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/member/board_member_detail_response.dart';
import 'package:trellis_mobile_app/models/member/board_member_request.dart';
import 'package:trellis_mobile_app/repository/member_repository.dart';

import '../../../models/board/board_response.dart';
import '../../../models/user/user_response.dart';
import '../../../repository/user_repository.dart';
import '../../dashboard/dashboard_controller.dart';
import '../board_menu/board_menu_controller.dart';

class InviteBoardMemberController extends GetxController {
  var dashboardController = Get.find<DashBoardController>();
  final boardMenuController = Get.find<BoardMenuController>();
  final memberRepository = Get.find<MemberRepository>();
  var userRepository = Get.find<UserRepository>();
  BoardResponse? currentBoard;
  var keyword = "".obs;
  var litsInviteMember = <UserResponse>[].obs;

  var listUserBySearch = <UserResponse>[].obs;
  @override
  void onInit() {
    initData();
    super.onInit();

    debounce(
      keyword,
      (_) {
        // return new keyword
        searchUserByEmail(_.toString());
      },
      time: const Duration(seconds: 2),
    );
  }

  void initData() {
    currentBoard = boardMenuController.currentBoard;
  }

  bool isDuplicateLitsInviteMember(String uid) {
    for (UserResponse user in litsInviteMember) {
      if (user.uid.compareTo(uid) == 0) {
        return true;
      }
    }
    return false;
  }

  void searchUserByEmail(String keyword) {
    userRepository
        .searchUserInWorkspace(keyword, -1, dashboardController.boardIdSelected)
        .then(
      (value) {
        listUserBySearch.assignAll(value);
      },
    );
  }

  void inviteMulti() {
    EasyLoading.show(status: "please_wait".tr);
    var listInviteMulti = <BoardMemberRequest>[];

    // insert to workspace menu page
    var listMemberDetail = <BoardMemberDetailResponse>[];

    int boardId = dashboardController.boardIdSelected;
    for (UserResponse userResponse in litsInviteMember) {
      listInviteMulti.add(
        BoardMemberRequest(
            memberId: userResponse.uid, permission: 2, boardId: boardId),
      );

      listMemberDetail.add(
        BoardMemberDetailResponse(
            memberId: userResponse.uid,
            permission: 2,
            boardId: boardId,
            email: userResponse.email,
            firstName: userResponse.firstName,
            lastName: userResponse.lastName,
            avatarBackgroundColor: userResponse.avatarBackgroundColor,
            avatarURL: userResponse.avatarURL,
            createdTime: userResponse.createdTime,
            updatedTime: userResponse.updatedTime),
      );

      boardMenuController.listMember.addAll(listMemberDetail);
    }

    memberRepository.inviteMultiBoard(listInviteMulti).then((value) {
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }

      EasyLoading.showSuccess("create_success".tr);

      litsInviteMember.clear();

      Get.back();
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }

          EasyLoading.showError("error".tr);
          break;
        default:
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }

          EasyLoading.showError("error".tr);
          break;
      }
    });
  }
}
