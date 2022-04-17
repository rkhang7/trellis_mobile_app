import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/modules/board/invite_board_member/invite_board_member_controller.dart';
import 'package:trellis_mobile_app/repository/user_repository.dart';
import 'package:trellis_mobile_app/utils/colors.dart';

import '../../../models/user/user_response.dart';

class InviteBoardMemberPage extends StatelessWidget {
  InviteBoardMemberPage({Key? key}) : super(key: key);
  final inviteBoardMemberController = Get.find<InviteBoardMemberController>();

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
                      TextSpan(text: "${"add_user_to_board".tr}: "),
                      TextSpan(
                          text: inviteBoardMemberController.currentBoard!.name,
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
                            inviteBoardMemberController.litsInviteMember[index];
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
                                        inviteBoardMemberController
                                            .litsInviteMember
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
                      itemCount:
                          inviteBoardMemberController.litsInviteMember.length,
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
                    return await inviteBoardMemberController.userRepository
                        .searchUserInWorkspace(
                      pattern,
                      -1,
                      inviteBoardMemberController
                          .dashboardController.boardIdSelected,
                    );
                  },
                  itemBuilder: (context, userResponse) {
                    return ListTile(
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
                          "${userResponse.first_name} ${userResponse.last_name}"),
                      subtitle: Text(userResponse.email),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    if (!inviteBoardMemberController
                        .isDuplicateLitsInviteMember(suggestion.uid)) {
                      inviteBoardMemberController.litsInviteMember
                          .add(suggestion);
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
    return inviteBoardMemberController.litsInviteMember.isEmpty
        ? Container()
        : Center(
            child: GestureDetector(
              onTap: () {
                inviteBoardMemberController.inviteMulti();
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
