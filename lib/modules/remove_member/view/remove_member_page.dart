import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/models/member/member_detail_response.dart';
import 'package:trellis_mobile_app/models/user/user_response.dart';
import 'package:trellis_mobile_app/modules/remove_member/controller/remove_member_controller.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';
import 'package:trellis_mobile_app/utils/colors.dart';

class RemoveMemberPage extends StatelessWidget {
  RemoveMemberPage({Key? key}) : super(key: key);
  final removeMemberController = Get.find<RemoveMemberController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200.h,
            child: Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${"members".tr} (${removeMemberController.workspaceMenuController.listMember.length})",
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
          _buildListMember(),
        ],
      ),
      appBar: _buildAppBar(),
    ));
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        "members".tr,
        style: boldTextStyle(color: Colors.white, size: 18),
      ),
      actions: [
        Center(
          child: GestureDetector(
            onTap: () {},
            child: Text(
              "${"leave".tr}   ".toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 56.sp,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildListMember() {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final userResponse =
              removeMemberController.workspaceMenuController.listMember[index];
          return InkWell(
            onTap: () {
              if (userResponse.member_id ==
                  removeMemberController.dashBoardController.currentId) {
                Get.bottomSheet(
                  Container(
                    height: 100,
                    color: Colors.blue,
                  ),
                );
              } else {
                if (removeMemberController.getPermissionForCurrentUser() == 1) {
                  Get.bottomSheet(
                      _buildRemoveMember(
                        userResponse,
                      ),
                      backgroundColor: Colors.white);
                }
              }
            },
            child: ListTile(
              leading: ClipOval(
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
              title: Text(
                "${userResponse.first_name} ${userResponse.last_name}",
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
            removeMemberController.workspaceMenuController.listMember.length);
  }

  Widget _buildRemoveMember(MemberDetailResponse userResponse) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: ClipOval(
            child: CachedNetworkImage(
              imageUrl: userResponse.avatar_url.isEmpty
                  ? "https://ui-avatars.com/api/?name=${userResponse.first_name}+${userResponse.last_name}&&size=120&&rounded=true&&background=${userResponse.avatar_background_color}&&color=ffffff&&bold=true"
                  : userResponse.avatar_url,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) {
                return const Icon(Icons.error);
              },
            ),
          ),
          title: Text(
            "${userResponse.first_name} ${userResponse.last_name}",
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
            onPressed: () {},
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
