import 'package:cached_network_image/cached_network_image.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/models/member/board_member_detail_response.dart';
import 'package:trellis_mobile_app/modules/board/remove_board_member/remove_board_member_controller.dart';
import 'package:trellis_mobile_app/utils/colors.dart';

class RemoveBoardMemberPage extends StatelessWidget {
  RemoveBoardMemberPage({Key? key}) : super(key: key);
  final removeBoardMemberController = Get.find<RemoveBoardMemberController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 200.h,
              child: Padding(
                padding: EdgeInsets.only(left: 30.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${"members".tr} (${removeBoardMemberController.boardMenuController.listMember.length})",
                    style:
                        TextStyle(color: Colors.grey.shade800, fontSize: 64.sp),
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: Colors.grey.shade800,
            ),
            Obx(
              () => _buildListMember(),
            ),
          ],
        ),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        "members".tr,
        style: boldTextStyle(color: Colors.white, size: 18),
      ),
      actions: [
        Obx(() => _buildLeave(context)),
      ],
    );
  }

  Widget _buildLeave(BuildContext context) {
    return Visibility(
      visible:
          removeBoardMemberController.listMember.length == 1 ? false : true,
      child: Center(
        child: GestureDetector(
          onTap: () async {
            if (await confirm(
              context,
              title: Text('confirm'.tr),
              content: Text('would_you_live_to_leave_board'.tr),
              textOK: Text(
                'yes'.tr,
                style: TextStyle(fontSize: 64.sp),
              ),
              textCancel: Text(
                'no'.tr,
                style: TextStyle(fontSize: 64.sp),
              ),
            )) {
              removeBoardMemberController.leaveWorkspace();
            }
          },
          child: Text(
            "${"leave".tr}   ".toUpperCase(),
            style: TextStyle(
                color: Colors.white,
                fontSize: 56.sp,
                letterSpacing: 2,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildListMember() {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final userResponse =
              removeBoardMemberController.boardMenuController.listMember[index];
          return InkWell(
            onTap: () {
              if (userResponse.memberId ==
                  removeBoardMemberController.dashBoardController.currentId) {
              } else {
                if (removeBoardMemberController.getPermissionForCurrentUser() ==
                    1) {
                  Get.bottomSheet(_buildRemoveMember(userResponse, index),
                      backgroundColor: Colors.white);
                }
              }
            },
            child: ListTile(
              leading: ClipOval(
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
              title: Text(
                "${userResponse.firstName} ${userResponse.lastName}",
                style: const TextStyle(overflow: TextOverflow.clip),
              ),
              subtitle: Text(
                userResponse.email,
                style: const TextStyle(overflow: TextOverflow.clip),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      userResponse.permission == 1 ? "admin".tr : "members".tr),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount:
            removeBoardMemberController.boardMenuController.listMember.length);
  }

  Widget _buildRemoveMember(BoardMemberDetailResponse userResponse, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 36.h,
        ),
        ListTile(
          leading: ClipOval(
            child: CachedNetworkImage(
              imageUrl: userResponse.avatarUrl.isEmpty
                  ? "https://ui-avatars.com/api/?name=${userResponse.firstName}+${userResponse.lastName}&&size=120&&rounded=true&&background=${userResponse.avatarBackgroundColor}&&color=ffffff&&bold=true"
                  : userResponse.avatarUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) {
                return const Icon(Icons.error);
              },
            ),
          ),
          title: Text(
            "${userResponse.firstName} ${userResponse.lastName}",
            style: const TextStyle(overflow: TextOverflow.clip),
          ),
          subtitle: Text(
            userResponse.email,
            style: const TextStyle(overflow: TextOverflow.clip),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Divider(
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            "admin".tr,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 72.sp),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            "admin_permission_explain".tr,
            style: TextStyle(fontSize: 56.sp),
          ),
        ),
        SizedBox(
          height: 36.h,
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              removeBoardMemberController.removeMemberFormBoard(
                  userResponse.memberId, index);
            },
            child: Text("remove_from_workspace".tr),
            style: ElevatedButton.styleFrom(primary: Colors.deepOrangeAccent),
          ),
        ),
        SizedBox(
          height: 72.h,
        ),
      ],
    );
  }
}
