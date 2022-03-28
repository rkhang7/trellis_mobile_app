import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';
import 'package:trellis_mobile_app/utils/colors.dart';

class WorkspaceMenuPage extends StatelessWidget {
  const WorkspaceMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(18),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 96.sp,
                  ),
                  SizedBox(
                    width: 60.w,
                  ),
                  Text(
                    "members".tr,
                    style: TextStyle(
                      fontSize: 64.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 140.w,
                  ),
                  Expanded(
                    child: Wrap(
                      runSpacing: 20.h,
                      spacing: 20.h,
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      children: [
                        Image.asset(
                          "assets/icons/logo.png",
                          width: 40,
                          height: 40,
                        ),
                        Image.asset(
                          "assets/icons/logo.png",
                          width: 40,
                          height: 40,
                        ),
                        Image.asset(
                          "assets/icons/logo.png",
                          width: 40,
                          height: 40,
                        ),
                        Image.asset(
                          "assets/icons/logo.png",
                          width: 40,
                          height: 40,
                        ),
                        Image.asset(
                          "assets/icons/logo.png",
                          width: 40,
                          height: 40,
                        ),
                        Image.asset(
                          "assets/icons/logo.png",
                          width: 40,
                          height: 40,
                        ),
                        Image.asset(
                          "assets/icons/logo.png",
                          width: 40,
                          height: 40,
                        ),
                        Image.asset(
                          "assets/icons/logo.png",
                          width: 40,
                          height: 40,
                        ),
                        Image.asset(
                          "assets/icons/logo.png",
                          width: 40,
                          height: 40,
                        ),
                        Image.asset(
                          "assets/icons/logo.png",
                          width: 40,
                          height: 40,
                        ),
                        Image.asset(
                          "assets/icons/logo.png",
                          width: 40,
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Center(
                child: SizedBox(
                  width: Get.width * 0.7,
                  child: ElevatedButton(
                    style: ButtonStyle(),
                    onPressed: () async {
                      await Get.toNamed(AppRoutes.INVITE_MEMBER);
                    },
                    child: Text(
                      "invite".tr,
                      style: TextStyle(fontSize: 64.sp),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      appBar: _buildAppBar(),
    );
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      leading: const CloseButton(),
      title: Text(
        "workspace_menu".tr,
        style: boldTextStyle(color: Colors.white, size: 18),
      ),
      elevation: 2,
    );
  }
}
