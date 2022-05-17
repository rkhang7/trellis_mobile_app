import 'package:awesome_dialog/awesome_dialog.dart' as dialog;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
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
        child: SingleChildScrollView(
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
              _buildMyCalendar(context),
              SizedBox(
                height: 80.h,
              ),
              _buildActivityArea(context),
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
              _buildEditLabelArea(context),
              SizedBox(
                height: 80.h,
              ),
              _buildDeleteBoardArea(context),
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

  Widget _buildEditLabelArea(BuildContext context) {
    return InkWell(
      onTap: () {
        openDialog(context).show();
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 18),
        height: 200.h,
        child: Row(
          children: [
            Icon(
              Icons.label,
              size: 72.sp,
            ),
            SizedBox(width: 60.w),
            Text(
              "edit_label".tr,
              style: TextStyle(fontSize: 64.sp),
            ),
          ],
        ),
      ),
    );
  }

  dialog.AwesomeDialog openDialog(BuildContext context) {
    boardMenuController.getListLabel();
    return dialog.AwesomeDialog(
      context: context,
      animType: dialog.AnimType.SCALE,
      dialogType: dialog.DialogType.NO_HEADER,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text(
              "edit_label".tr,
              style: TextStyle(
                color: Colors.black,
                fontSize: 72.sp,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Obx(
            () => ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: boardMenuController.listLabel.length,
              itemBuilder: (_, index) {
                final label = boardMenuController.listLabel[index];
                return InkWell(
                  onTap: () {
                    boardMenuController.updateLabelColorSelected(label.color);
                    boardMenuController.editingLabel.value = true;
                    boardMenuController.labelNameController.text = label.name;
                    openBottomSheet(label.label_id);
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 40,
                    decoration: BoxDecoration(
                      color: HexColor(label.color),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        label.name,
                        style: TextStyle(color: Colors.white, fontSize: 81.sp),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 8,
                );
              },
            ),
          ),
        ],
      ),
      btnOk: TextButton(
        onPressed: () async {
          await openBottomSheet(-1);
        },
        child: Text("create_new_label".tr),
      ),
      btnCancel: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text("cancel".tr),
      ),
    );
  }

  Future<dynamic> openBottomSheet(int labelId) {
    return Get.bottomSheet(
      Container(
        height: 1200.h,
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boardMenuController.editingLabel.isFalse
                ? Text("new_label".tr)
                : Text("edit_label".tr),
            TextFormField(
              controller: boardMenuController.labelNameController,
              autofocus: false,
              decoration: InputDecoration(
                hintText: "label_name".tr,
                labelStyle: const TextStyle(color: Colors.green),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2),
                ),
              ),
              cursorColor: Colors.green,
              cursorHeight: 25,
              onChanged: (value) {},
              maxLines: null,
            ),
            Expanded(
              child: Obx(
                () => GridView.builder(
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 2,
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 3,
                  ),
                  shrinkWrap: true,
                  itemCount: boardMenuController.listLabelColor.length,
                  itemBuilder: (context, index) {
                    final myColor = boardMenuController.listLabelColor[index];
                    return InkWell(
                      onTap: () async {
                        boardMenuController.changeBackgroundBoard(index);
                      },
                      child: myColor.isSelect
                          ? Card(
                              color: HexColor(myColor.color),
                              child: const Icon(Icons.check,
                                  size: 40, color: Colors.white),
                            )
                          : Card(
                              color: HexColor(myColor.color),
                            ),
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "cancel".tr,
                    style: TextStyle(fontSize: 64.sp),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    boardMenuController.editingLabel.isFalse
                        ? boardMenuController.createLabel()
                        : boardMenuController.updateLabel(labelId);
                  },
                  child: Text(
                    "done".tr,
                    style: TextStyle(fontSize: 64.sp),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildActivityArea(BuildContext context) {
    return InkWell(
      onTap: () {
        openHistoricalDialog(context);
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 18),
        height: 200.h,
        child: Row(
          children: [
            Icon(
              Icons.pending_actions,
              size: 72.sp,
            ),
            SizedBox(width: 60.w),
            Text(
              "activity".tr,
              style: TextStyle(fontSize: 64.sp),
            ),
          ],
        ),
      ),
    );
  }

  Future openHistoricalDialog(BuildContext context) {
    return dialog.AwesomeDialog(
      context: context,
      animType: dialog.AnimType.SCALE,
      dialogType: dialog.DialogType.NO_HEADER,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 2000.h,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: boardMenuController.listBoardHistorical.length,
              itemBuilder: (_, index) {
                final historical =
                    boardMenuController.listBoardHistorical[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            height: 45,
                            width: 45,
                            imageUrl: historical.avatar_url.isEmpty
                                ? "https://ui-avatars.com/api/?name=${historical.first_name}+${historical.last_name}&&size=120&&rounded=true&&background=${historical.avatar_background_color}&&color=ffffff&&bold=true"
                                : historical.avatar_url,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) {
                              return const Icon(Icons.error);
                            },
                          ),
                          SizedBox(
                            width: 40.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  historical.content,
                                  style: TextStyle(
                                    // overflow: TextOverflow.fade,
                                    fontSize: 64.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 50.h,
                                ),
                                Text(
                                  boardMenuController.handleDateTimeShowUI(
                                      historical.created_time),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  color: Colors.grey,
                );
              },
            ),
          )
        ],
      ),
      btnOkOnPress: () {},
    ).show();
  }

  _buildMyCalendar(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.MY_CALENDAR);
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 18),
        height: 200.h,
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              size: 72.sp,
            ),
            SizedBox(width: 60.w),
            Text(
              "my_calendar".tr,
              style: TextStyle(fontSize: 64.sp),
            ),
          ],
        ),
      ),
    );
  }
}
