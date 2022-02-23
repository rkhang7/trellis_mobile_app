import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/modules/walk_through/controller/walk_through_controller.dart';
import 'package:trellis_mobile_app/modules/walk_through/view/widget.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';
import 'package:trellis_mobile_app/utils/colors.dart';
import 'package:trellis_mobile_app/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalkThroughPage extends StatelessWidget {
  WalkThroughPage({Key? key}) : super(key: key);
  final walkThroughController = Get.find<WakThroughController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  left: Get.width / 2 - 270.w,
                  child: Text(
                    TCAppName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 200.sp,
                        letterSpacing: 2),
                  ),
                  top: 50.h,
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
              padding: EdgeInsets.fromLTRB(0, 15.w, 0, 15.w),
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 400.w,
                        height: 200.h,
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
                          child: Text("sign_up".tr,
                              style: TextStyle(
                                  color: textColorPrimary, fontSize: 56.sp)),
                        ),
                      ),
                      SizedBox(
                        width: 400.w,
                        height: 200.h,
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
                          child: Text("sign_in".tr,
                              style: TextStyle(
                                  color: textColorPrimary, fontSize: 56.sp)),
                        ),
                      ),
                    ],
                  ),
                  20.height,
                  Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "termsCondition1".tr,
                              style: secondaryTextStyle(
                                  color: textColorSecondary,
                                  size: 56.sp.toInt())),
                          TextSpan(
                            text: "termsCondition2".tr,
                            style: boldTextStyle(
                              color: textColorPrimary,
                              size: 56.sp.toInt(),
                            ),
                          ),
                          TextSpan(
                            text: "termsCondition3".tr,
                            style: secondaryTextStyle(
                              color: textColorSecondary,
                              size: 56.sp.toInt(),
                            ),
                          ),
                          TextSpan(
                            text: "termsCondition4".tr,
                            style: boldTextStyle(
                              color: textColorPrimary,
                              size: 56.sp.toInt(),
                            ),
                          ),
                          TextSpan(
                            text: "termsCondition5".tr,
                            style: secondaryTextStyle(
                              color: textColorSecondary,
                              size: 56.sp.toInt(),
                            ),
                          ),
                        ],
                      ),
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
      height: 480.h,
      width: Get.width,
      color: Colors.white,
      child: Column(
        children: [
          buildItemAuth(
            label: "signUpEmailLabel".tr,
            iconPath: "assets/icons/email.png",
            onClick: () {
              Get.toNamed(AppRoutes.SIGN_UP);
            },
          ),
          buildItemAuth(
            label: "signUpGoogleLabel".tr,
            iconPath: "assets/icons/google.png",
            onClick: () {},
          ),
        ],
      ),
    ));
  }

  Future<dynamic> openBottomSheetSignIn() {
    return Get.bottomSheet(Container(
      height: 480.h,
      width: Get.width,
      color: Colors.white,
      child: Column(
        children: [
          buildItemAuth(
              label: "signInEmailLabel".tr,
              iconPath: "assets/icons/email.png",
              onClick: () {
                Get.toNamed(AppRoutes.SIGN_IN);
              }),
          buildItemAuth(
              label: "signInGoogleLabel".tr,
              iconPath: "assets/icons/google.png",
              onClick: () {
                walkThroughController.signInByGoogleAccount().then((value) => {
                      Get.offAllNamed(
                        AppRoutes.DASHBOARD,
                      ),
                      EasyLoading.instance.loadingStyle =
                          EasyLoadingStyle.custom,
                      EasyLoading.showSuccess("Đăng nhập thành công"),
                    });
              }),
        ],
      ),
    ));
  }
}
