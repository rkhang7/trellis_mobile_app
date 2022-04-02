import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/member/member_detail_response.dart';
import 'package:trellis_mobile_app/models/member/member_request.dart';
import 'package:trellis_mobile_app/models/user/user_response.dart';
import 'package:trellis_mobile_app/models/workspace/workspace_response.dart';
import 'package:trellis_mobile_app/modules/workspace_menu/controller/workspace_menu_controller.dart';
import 'package:trellis_mobile_app/repository/member_repository.dart';
import 'package:trellis_mobile_app/repository/user_repository.dart';

import '../../dashboard/controller/dashboard_controller.dart';

class InviteMemberController extends GetxController {
  var dashboardController = Get.find<DashBoardController>();
  var emailController = TextEditingController();
  var userRepository = Get.find<UserRepository>();
  var memberRepository = Get.find<MemberRepository>();
  var workspaceMenuController = Get.find<WorkspaceMenuController>();
  WorkSpaceResponse? currentWorkspace;
  var keyword = "".obs;

  var litsInviteMember = <UserResponse>[].obs;

  var listUserBySearch = <UserResponse>[].obs;
  @override
  void onInit() {
    super.onInit();
    initData();
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
    currentWorkspace = dashboardController.workspaceSelected.value;
  }

  void searchUserByEmail(String keyword) {
    userRepository
        .searchUserInWorkspace(
            keyword, dashboardController.workspaceSelected.value.workspace_id)
        .then(
      (value) {
        listUserBySearch.assignAll(value);
        log(listUserBySearch.toString());
      },
    );
  }

  bool isDuplicateLitsInviteMember(String uid) {
    for (UserResponse user in litsInviteMember) {
      if (user.uid.compareTo(uid) == 0) {
        return true;
      }
    }
    return false;
  }

  void inviteMulti() {
    EasyLoading.show(status: "please_wait".tr);
    var listInviteMulti = <MemberRequest>[];

    // insert to workspace menu page
    var listMemberDetail = <MemberDetailResponse>[];

    int workspaceId = dashboardController.workspaceSelected.value.workspace_id;
    for (UserResponse userResponse in litsInviteMember) {
      listInviteMulti.add(
        MemberRequest(
            memberId: userResponse.uid,
            permission: 2,
            workspaceId: workspaceId),
      );

      listMemberDetail.add(
        MemberDetailResponse(
            member_id: userResponse.uid,
            permission: 2,
            workspace_id: workspaceId,
            email: userResponse.email,
            first_name: userResponse.first_name,
            last_name: userResponse.last_name,
            avatar_background_color: userResponse.avatar_background_color,
            avatar_url: userResponse.avatar_url,
            created_time: userResponse.created_time,
            updated_time: userResponse.updated_time),
      );

      workspaceMenuController.listMember.addAll(listMemberDetail);
    }

    memberRepository.inviteMulti(listInviteMulti).then((value) {
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
