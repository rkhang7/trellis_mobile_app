import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';
import 'package:trellis_mobile_app/service/auth_service.dart';
import 'package:trellis_mobile_app/utils/colors.dart';
import 'package:trellis_mobile_app/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class WakThroughController extends GetxController {
  var pageController = PageController();
  List<Widget> pages = [];
  var selectedIndex = 0;
  var isLogin = false.obs;
  var currentIndexWalkThrough = 0.obs;
  var authService = Get.find<AuthService>();

  var selectedLanguage = "VN".obs;

  Timer? timer;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
    checkLogin();
    timer = Timer.periodic(const Duration(seconds: 3), (Timer t) => autoLoop());
  }

  Future<User?> signInByGoogleAccount() async {
    return await authService.signInWithGoogle().then((value) {
      if (value != null) {
        Get.offAllNamed(AppRoutes.DASHBOARD);
      }
    });
  }

  void checkLogin() {
    authService.getUid().then(
      (value) {
        if (value == null) {
        } else {
          Get.offNamed(AppRoutes.DASHBOARD);
        }
      },
    );
  }

  void autoLoop() {
    if (currentIndexWalkThrough.value == 3) {
      currentIndexWalkThrough.value = 0;
    } else {
      currentIndexWalkThrough.value += 1;
    }
    if (pageController.hasClients) {
      pageController.jumpToPage(currentIndexWalkThrough.value);
    }
  }
}
