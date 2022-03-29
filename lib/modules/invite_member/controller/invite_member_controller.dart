import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/user/user_response.dart';
import 'package:trellis_mobile_app/models/workspace/workspace_response.dart';
import 'package:trellis_mobile_app/repository/user_repository.dart';

import '../../dashboard/controller/dashboard_controller.dart';

class InviteMemberController extends GetxController {
  var dashboardController = Get.find<DashBoardController>();
  var emailController = TextEditingController();
  var userRepository = Get.find<UserRepository>();
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
    userRepository.searchUser(keyword).then(
      (value) {
        listUserBySearch.assignAll(value);
        log(listUserBySearch.toString());
      },
    );
  }
}
