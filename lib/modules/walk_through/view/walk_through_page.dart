import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/modules/walk_through/controller/walk_through_controller.dart';
import 'package:trellis_mobile_app/modules/walk_through/view/widget.dart';
import 'package:trellis_mobile_app/utils/colors.dart';
import 'package:trellis_mobile_app/utils/constants.dart';

class WalkThroughPage extends StatelessWidget {
  WalkThroughPage({Key? key}) : super(key: key);
  final walkThroughController = Get.find<WakThroughController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  left: Get.width / 2 - 70,
                  child: Text(
                    TCAppName,
                    style: boldTextStyle(
                        color: Colors.white, size: 30, letterSpacing: 2),
                  ),
                  top: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.height * .75,
                      child: PageView(
                        controller: walkThroughController.pageController,
                        scrollDirection: Axis.horizontal,
                        children: walkThroughController.pages,
                        onPageChanged: (index) {
                          walkThroughController.selectedIndex = index;
                        },
                      ),
                    ),
                  ],
                ),
                AnimatedPositioned(
                  duration: const Duration(seconds: 1),
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: DotIndicator(
                      pages: walkThroughController.pages,
                      indicatorColor: Colors.white,
                      pageController: walkThroughController.pageController),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            await openBottomSheetSignUp();
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 20),
                              primary: buttonColor),
                          child: Text(signUp,
                              style: primaryTextStyle(
                                  color: textColorPrimary, size: 12)),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            await openBottomSheetSignIn();
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 20),
                              primary: buttonColor),
                          child: Text(logIn,
                              style: primaryTextStyle(
                                  color: textColorPrimary, size: 12)),
                        ),
                      ),
                    ],
                  ),
                  20.height,
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: termsCondition1,
                            style: secondaryTextStyle(
                                color: textColorSecondary, size: 13)),
                        TextSpan(
                            text: termsCondition2,
                            style: boldTextStyle(
                                color: textColorPrimary, size: 13)),
                        TextSpan(
                            text: termsCondition3,
                            style: secondaryTextStyle(
                                color: textColorSecondary, size: 13)),
                        TextSpan(
                            text: termsCondition4,
                            style: boldTextStyle(
                                color: textColorPrimary, size: 13)),
                        TextSpan(
                            text: termsCondition5,
                            style: secondaryTextStyle(
                                color: textColorSecondary, size: 12)),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  Future<dynamic> openBottomSheetSignUp() {
    return Get.bottomSheet(Container(
      height: 120,
      width: Get.width,
      color: Colors.white,
      child: Column(
        children: [
          buildItemAuth(
              label: signUpEmailLabel,
              iconPath: "assets/icons/email.png",
              onClick: () {}),
          buildItemAuth(
              label: signUpGoogleLabel,
              iconPath: "assets/icons/google.png",
              onClick: () {}),
        ],
      ),
    ));
  }

  Future<dynamic> openBottomSheetSignIn() {
    return Get.bottomSheet(Container(
      height: 120,
      width: Get.width,
      color: Colors.white,
      child: Column(
        children: [
          buildItemAuth(
              label: signInEamilLabel,
              iconPath: "assets/icons/email.png",
              onClick: () {}),
          buildItemAuth(
              label: signInGoogleLabel,
              iconPath: "assets/icons/google.png",
              onClick: () {}),
        ],
      ),
    ));
  }
}
