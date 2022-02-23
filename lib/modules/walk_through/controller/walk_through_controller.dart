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

  Timer? timer;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
    initPage();
    checkLogin();
    timer = Timer.periodic(const Duration(seconds: 3), (Timer t) => autoLoop());
  }

  initPage() {
    pages = [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/walkthrough1.png",
            height: 250,
          ),
          40.height,
          SizedBox(
            width: 300,
            child: Text(
              "title_walk_through_1".tr,
              style: boldTextStyle(
                color: textColorPrimary,
                size: 20,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 340,
            child: Text(
              "description_walk_through_1".tr,
              style:
                  primaryTextStyle(color: textColorPrimary, letterSpacing: 1),
              textAlign: TextAlign.center,
            ),
          ),
          // commonCacheImageWidget(tc_WalkThroughImg1.validate(), height: 230),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/walkthrough2.png",
            height: 250,
          ),
          40.height,
          SizedBox(
            width: 250,
            child: Text(
              "title_walk_through_2".tr,
              style: boldTextStyle(
                  color: textColorPrimary, size: 20, letterSpacing: 1),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 240,
            child: Text(
              "description_walk_through_2".tr,
              style:
                  primaryTextStyle(color: textColorPrimary, letterSpacing: 1),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/walkthrough3.png",
            height: 250,
          ),
          40.height,
          Text(
            "title_walk_through_3".tr,
            style: boldTextStyle(
                color: textColorPrimary, size: 20, letterSpacing: 1),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
              width: 260,
              child: Text(
                "description_walk_through_3".tr,
                style: primaryTextStyle(
                  color: textColorPrimary,
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.center,
              )),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/walkthrough4.png",
            height: 250,
          ),
          40.height,
          Text(
            "title_walk_through_4".tr,
            style: boldTextStyle(
                color: textColorPrimary, size: 20, letterSpacing: 1),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 260,
            child: Text(
              "description_walk_through_4".tr,
              style: primaryTextStyle(
                color: textColorPrimary,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ];
  }

  Future<User?> signInByGoogleAccount() async {
    return await authService.signInWithGoogle();
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

    pageController.jumpToPage(currentIndexWalkThrough.value);
  }
}
