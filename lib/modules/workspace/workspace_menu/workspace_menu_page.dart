import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';
import 'package:trellis_mobile_app/utils/colors.dart';

import 'workspace_menu_controller.dart';

class WorkspaceMenuPage extends StatelessWidget {
  WorkspaceMenuPage({Key? key}) : super(key: key);
  final workspaceMenuController = Get.find<WorkspaceMenuController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.REMOVE_MEMBER);
              },
              child: Obx(
                () => _buildInviteMemberArea(),
              ),
            ),
            SizedBox(
              height: 80.h,
            ),
            _buildWorkspaceSettingArea(),
          ],
        ),
      ),
      appBar: _buildAppBar(),
    );
  }

  Widget _buildInviteMemberArea() {
    return Container(
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
                  children:
                      workspaceMenuController.listMember.map((userResponse) {
                    return Container(
                      width: 50,
                      height: 50,
                      color: Colors.white,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: userResponse.avatarUrl.isEmpty
                              ? "https://ui-avatars.com/api/?name=${userResponse.firstName}+${userResponse.lastName}&&size=120&&rounded=true&&background=${userResponse.avatarBackgroundColor}&&color=ffffff&&bold=true"
                              : userResponse.avatarUrl,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                    );
                    // return Container(
                    //   width: 50,
                    //   height: 50,
                    //   color: Colors.red,
                    // );
                  }).toList(),
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
          ),
        ],
      ),
    );
  }

  Widget _buildWorkspaceSettingArea() {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.UPDATE_WORKSPACE);
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 18),
        height: 200.h,
        child: Row(
          children: [
            Icon(
              FontAwesomeIcons.penFancy,
              size: 72.sp,
            ),
            SizedBox(width: 60.w),
            Text(
              "workspace_setting".tr,
              style: TextStyle(fontSize: 64.sp),
            ),
          ],
        ),
      ),
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
