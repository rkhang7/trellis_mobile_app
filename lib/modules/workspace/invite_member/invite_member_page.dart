import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/models/user/user_response.dart';
import 'package:trellis_mobile_app/utils/colors.dart';

import 'invite_member_controller.dart';

class InviteMemberPage extends StatelessWidget {
  InviteMemberPage({Key? key}) : super(key: key);
  final inviteMemberController = Get.find<InviteMemberController>();
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(18),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 64.sp),
                    children: [
                      TextSpan(text: "${"add_user_to_workspace".tr}: "),
                      TextSpan(
                          text: inviteMemberController.currentWorkspace!.name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Obx(() {
                  return SingleChildScrollView(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        UserResponse userResponse =
                            inviteMemberController.litsInviteMember[index];
                        return Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                padding: EdgeInsets.only(left: 30.w),
                                width: Get.width / 1.55,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(48.h)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      userResponse.email,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 56.sp,
                                          overflow: TextOverflow.visible),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        inviteMemberController.litsInviteMember
                                            .removeAt(index);
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        size: 24,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        );
                      },
                      itemCount: inviteMemberController.litsInviteMember.length,
                    ),
                  );
                }),
                TypeAheadField<UserResponse>(
                  debounceDuration: const Duration(seconds: 1),
                  textFieldConfiguration: const TextFieldConfiguration(
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    return await inviteMemberController.userRepository
                        .searchUserInWorkspace(
                            pattern,
                            inviteMemberController.dashboardController
                                .workspaceSelected.value.workspaceId,
                            -1);
                  },
                  itemBuilder: (context, userResponse) {
                    return ListTile(
                      leading: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: userResponse.avatarURL.isEmpty
                              ? "https://ui-avatars.com/api/?name=${userResponse.firstName}+${userResponse.lastName}&&size=120&&rounded=true&&background=${userResponse.avatarBackgroundColor}&&color=ffffff&&bold=true"
                              : userResponse.avatarURL,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                      title: Text(
                          "${userResponse.firstName} ${userResponse.lastName}"),
                      subtitle: Text(userResponse.email),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    if (!inviteMemberController
                        .isDuplicateLitsInviteMember(suggestion.uid)) {
                      inviteMemberController.litsInviteMember.add(suggestion);
                    } else {
                      EasyLoading.showInfo("you_have_selected_this_user".tr);
                    }
                  },
                  hideSuggestionsOnKeyboardHide: false,
                  noItemsFoundBuilder: (_) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "user_not_found".tr,
                        style: TextStyle(fontSize: 64.sp, color: Colors.red),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        "add_members".tr,
        style: boldTextStyle(color: Colors.white, size: 18),
      ),
      actions: [
        Obx(
          () => _buildActions(),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return inviteMemberController.litsInviteMember.isEmpty
        ? Container()
        : Center(
            child: GestureDetector(
              onTap: () {
                inviteMemberController.inviteMulti();
              },
              child: Text(
                "${"add".tr}  ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 64.sp,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
  }
}
