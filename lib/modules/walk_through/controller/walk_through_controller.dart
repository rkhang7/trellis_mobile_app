import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  var authService = Get.find<AuthService>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initPage();
    checkLogin();
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
              W1title,
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
              W1SubTitle,
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
              W2title,
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
              W2SubTitle,
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
            W3title,
            style: boldTextStyle(
                color: textColorPrimary, size: 20, letterSpacing: 1),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
              width: 260,
              child: Text(
                W3SubTitle,
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
            W4title,
            style: boldTextStyle(
                color: textColorPrimary, size: 20, letterSpacing: 1),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 260,
            child: Text(
              W4SubTitle,
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
}
