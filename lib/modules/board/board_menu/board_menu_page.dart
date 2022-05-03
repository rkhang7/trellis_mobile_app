import 'package:awesome_dialog/awesome_dialog.dart' as dialog;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/modules/board/board_menu/board_menu_controller.dart';

import '../../../routes/app_routes.dart';

class BoardMenuPage extends StatelessWidget {
  BoardMenuPage({Key? key}) : super(key: key);
  final boardMenuController = Get.find<BoardMenuController>();
  get backgroundColor => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.REMOVE_BOARD_MEMBER);
              },
              child: Obx(
                () => _buildInviteMemberArea(),
              ),
            ),
            SizedBox(
              height: 80.h,
            ),
            _buildWorkspaceSettingArea(),
            SizedBox(
              height: 80.h,
            ),
            _buildBackgroundColorArea(),
            SizedBox(
              height: 80.h,
            ),
            _buildDeleteBoardArea(context),
          ],
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
        "board_menu".tr,
        style: boldTextStyle(color: Colors.white, size: 18),
      ),
      elevation: 2,
    );
  }

  _buildInviteMemberArea() {
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
                  children: boardMenuController.listMember.map((userResponse) {
                    return Container(
                      width: 50,
                      height: 50,
                      color: Colors.white,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: userResponse.avatar_url.isEmpty
                              ? "https://ui-avatars.com/api/?name=${userResponse.first_name}+${userResponse.last_name}&&size=120&&rounded=true&&background=${userResponse.avatar_background_color}&&color=ffffff&&bold=true"
                              : userResponse.avatar_url,
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
                  await Get.toNamed(AppRoutes.INVITE_BOARD_MEMBER);
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
        Get.toNamed(AppRoutes.UPDATE_BOARD);
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
              "board_setting".tr,
              style: TextStyle(fontSize: 64.sp),
            ),
          ],
        ),
      ),
    );
  }

  _buildBackgroundColorArea() {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.BOARD_BACKGROUND);
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 18),
        height: 200.h,
        child: Row(
          children: [
            Icon(
              Icons.color_lens,
              size: 72.sp,
            ),
            SizedBox(width: 60.w),
            Text(
              "background_color".tr,
              style: TextStyle(fontSize: 64.sp),
            ),
          ],
        ),
      ),
    );
  }

  _buildDeleteBoardArea(BuildContext context) {
    return Visibility(
      visible: true,
      child: InkWell(
        onTap: () {
          dialog.AwesomeDialog(
            context: context,
            dialogType: dialog.DialogType.WARNING,
            animType: dialog.AnimType.BOTTOMSLIDE,
            title: 'delete_board'.tr,
            desc: 'are_you_sure_delete_this_board'.tr,
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
          ).show();
        },
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 18),
          height: 200.h,
          child: Row(
            children: [
              Icon(
                Icons.delete,
                size: 72.sp,
                color: Colors.red,
              ),
              SizedBox(width: 60.w),
              Text("delete_board".tr,
                  style: TextStyle(fontSize: 64.sp, color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
