import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:trellis_mobile_app/models/task/task_response.dart';
import 'package:trellis_mobile_app/modules/card/update_card/update_card_controller.dart';
import 'package:awesome_dialog/awesome_dialog.dart' as dialog;

class UpdateCardPage extends StatelessWidget {
  UpdateCardPage({Key? key}) : super(key: key);
  final updateCardController = Get.find<UpdateCardController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(
                () => _buildInfoCardArea(),
              ),
              SizedBox(
                height: 50.h,
              ),
              Obx(
                () => _buildQuickAction(context),
              ),
              SizedBox(
                height: 50.h,
              ),
              Obx(
                () => _buildEditDescriptionArea(),
              ),
              SizedBox(
                height: 50.h,
              ),
              _buildMemberArea(context),
              SizedBox(
                height: 50.h,
              ),
              _buildDateArea(),
              SizedBox(
                height: 50.h,
              ),
              Obx(
                () => _buildListTasks(),
              ),
            ],
          ),
        ),
      ),
      appBar: _buildAppBar(),
    );
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: Colors.white,
      ),
      leading: CloseButton(
        color: Colors.black,
        onPressed: () {
          updateCardController.handleLeading();
        },
      ),
      actions: [
        Obx(() => _buildAction()),
      ],
      title: Obx(() => _buildTitle()),
    );
  }

  Widget _buildTitle() {
    return updateCardController.editingName.isTrue
        ? Text(
            "edit_card_name".tr,
            style: TextStyle(color: Colors.black, fontSize: 64.sp),
          )
        : updateCardController.editingDescription.isTrue
            ? Text(
                "edit_card_description".tr,
                style: TextStyle(color: Colors.black, fontSize: 64.sp),
              )
            : updateCardController.addingTask.isTrue
                ? Text(
                    "add_task".tr,
                    style: TextStyle(color: Colors.black, fontSize: 64.sp),
                  )
                : updateCardController.editingTask.isTrue
                    ? Text(
                        "editing_task".tr,
                        style: TextStyle(color: Colors.black, fontSize: 64.sp),
                      )
                    : Container();
  }

  Widget _buildAction() {
    return updateCardController.editingName.isTrue
        ? IconButton(
            onPressed: () {
              updateCardController.cardNameIsEmpty.isTrue
                  ? null
                  : updateCardController.updateCardName();
            },
            icon: Icon(Icons.check,
                color: updateCardController.cardNameIsEmpty.isTrue
                    ? Colors.grey
                    : Colors.black),
          )
        : updateCardController.editingDescription.isTrue
            ? IconButton(
                onPressed: () {
                  updateCardController.updateCardDescription();
                },
                icon: const Icon(Icons.check, color: Colors.black),
              )
            : updateCardController.addingTask.isTrue
                ? IconButton(
                    onPressed: () {
                      updateCardController.addTask();
                    },
                    icon: const Icon(Icons.check, color: Colors.black),
                  )
                : updateCardController.editingTask.isTrue
                    ? IconButton(
                        onPressed: () {
                          updateCardController.updateTaskName(
                              updateCardController.taskIdSelected);
                        },
                        icon: const Icon(Icons.check, color: Colors.black),
                      )
                    : IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert, color: Colors.black),
                      );
  }

  Widget _buildInfoCardArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      width: Get.width,
      color: Colors.white,
      child: InkWell(
        onTap: () {
          updateCardController.editingName.value = true;
        },
        child: updateCardController.editingName.isFalse
            ? Text(
                updateCardController.cardUpdate.value.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 81.sp,
                ),
                maxLines: null,
              )
            : TextFormField(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 81.sp,
                ),
                maxLines: null,
                autofocus: true,
                controller: updateCardController.cardNameController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                cursorColor: Colors.green,
                cursorHeight: 25,
                onChanged: (value) {
                  if (value.trim().isEmpty) {
                    updateCardController.cardNameIsEmpty.value = true;
                  } else {
                    updateCardController.cardNameIsEmpty.value = false;
                  }
                },
              ),
      ),
    );
  }

  _buildEditDescriptionArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      width: Get.width,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Icon(Icons.vertical_distribute_sharp),
          SizedBox(
            width: 80.w,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                updateCardController.editingDescription.value = true;
              },
              child: updateCardController.editingDescription.isFalse
                  ? Text(
                      updateCardController.cardUpdate.value.description == ""
                          ? "add_card_description".tr
                          : updateCardController.cardUpdate.value.description,
                      style: TextStyle(color: Colors.black, fontSize: 64.sp),
                    )
                  : TextFormField(
                      minLines: 3,
                      style: TextStyle(color: Colors.black, fontSize: 64.sp),
                      maxLines: null,
                      autofocus: true,
                      controller:
                          updateCardController.cardDescriptionController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 2),
                        ),
                      ),
                      cursorColor: Colors.green,
                      cursorHeight: 25,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  _buildDateArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      width: Get.width,
      child: Column(
        children: [
          _buildStartDate(),
          10.height,
          _buildEndDate(),
        ],
      ),
    );
  }

  _buildEndDate() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Icon(null),
        10.width,
        GestureDetector(
            onTap: () {
              Get.defaultDialog(
                contentPadding:
                    const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                radius: 2,
                title: "due_date".tr,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Obx(
                          () => _buildDropdownDateEndDate(),
                        ),
                        30.width,
                        Obx(
                          () => _buildDropdownTimeEndDate(),
                        ),
                      ],
                    ),
                    10.height,
                    Text(
                      "set_reminder".tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    Obx(() => _buildDropdownRemind()),
                    10.height,
                    Text(
                      "reminder_desc".tr,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    10.height,
                  ],
                ),
                cancel: GestureDetector(
                  onTap: () {
                    Get.back();
                    // updateCardController.reminderCode.value = 0;
                    // updateCardController.endDatePicker.value =
                    //     DateTime.now().add(const Duration(days: 2));
                    // updateCardController.endTimePicker.value = "9:00";
                    // updateCardController.endDateTime.hour = 9;
                    // updateCardController.endDateTime.minute = 0;
                    // updateCardController.isAddMeToCard.value = true;
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 100, right: 20),
                    child: Text(
                      "cancel".tr,
                      style: const TextStyle(
                        color: Colors.blue,
                        letterSpacing: 3,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                confirm: GestureDetector(
                  onTap: () {
                    updateCardController.updateCardDueDate();
                  },
                  child: Text(
                    "done".tr,
                    style: const TextStyle(
                      color: Colors.blue,
                      letterSpacing: 3,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
            child: Obx(
              () => Text(
                "${"due_date".tr}: ${DateFormat('dd-MM, kk:mm').format(updateCardController.endDatePicker.value)}",
                style: primaryTextStyle(color: Colors.black),
              ),
            )),
      ],
    );
  }

  Widget _buildDropdownRemind() {
    return DropdownButton<int>(
      underline: Container(
        height: 1,
        color: Colors.black,
      ),
      isExpanded: true,
      hint: Text(
        updateCardController
            .getReminderByCode(updateCardController.reminderCode.value),
        style: const TextStyle(color: Colors.black),
      ),
      onChanged: (dynamic value) {
        updateCardController.reminderCode.value = value;
      },
      items: [
        DropdownMenuItem(
            child: ListTile(
              title: Text(
                "at_time_of_due_date".tr,
                style: primaryTextStyle(color: Colors.black),
              ),
            ),
            value: 0),
        DropdownMenuItem(
            child: ListTile(
              title: Text(
                "5 ${"minutes_ago".tr}",
                style: primaryTextStyle(color: Colors.black),
              ),
            ),
            value: 1),
        DropdownMenuItem(
            child: ListTile(
              title: Text(
                "10 ${"minutes_ago".tr}",
                style: primaryTextStyle(color: Colors.black),
              ),
            ),
            value: 2),
        DropdownMenuItem(
            child: ListTile(
              title: Text(
                "15 ${"minutes_ago".tr}",
                style: primaryTextStyle(color: Colors.black),
              ),
            ),
            value: 3),
        DropdownMenuItem(
            child: ListTile(
              title: Text(
                "1 ${"hours_ago".tr}",
                style: primaryTextStyle(color: Colors.black),
              ),
            ),
            value: 4),
        DropdownMenuItem(
            child: ListTile(
              title: Text(
                "2 ${"hours_ago".tr}",
                style: primaryTextStyle(color: Colors.black),
              ),
            ),
            value: 5),
        DropdownMenuItem(
            child: ListTile(
              title: Text(
                "1 ${"days_ago".tr}",
                style: primaryTextStyle(color: Colors.black),
              ),
            ),
            value: 6),
        DropdownMenuItem(
            child: ListTile(
              title: Text(
                "2 ${"days_ago".tr}",
                style: primaryTextStyle(color: Colors.black),
              ),
            ),
            value: 7),
      ],
    );
  }

  _buildDropdownTimeEndDate() {
    return SizedBox(
      width: 400.w,
      child: DropdownButton(
        underline: Container(
          height: 1,
          color: Colors.black,
        ),
        isExpanded: true,
        hint: Text(
          updateCardController.endTimePicker.value,
          style: primaryTextStyle(color: Colors.black),
        ),
        onChanged: (dynamic value) {},
        items: [
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "morning".tr,
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  updateCardController.endTimePicker.value = "09:00";
                  updateCardController.endDateTime.hour = 9;

                  Get.back();
                },
              ),
              value: '09:00'),
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "afternoon".tr,
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  updateCardController.endTimePicker.value = "13:00";
                  updateCardController.endDateTime.hour = 13;

                  Get.back();
                },
              ),
              value: '13:00'),
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "evening".tr,
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  updateCardController.endTimePicker.value = "17:00";
                  updateCardController.endDateTime.hour = 17;
                  Get.back();
                },
              ),
              value: '17:00'),
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "night".tr,
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  updateCardController.endTimePicker.value = "20:00";
                  updateCardController.endDateTime.hour = 20;
                  Get.back();
                },
              ),
              value: '20:00'),
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "pick_a_time".tr,
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  _selectEndTimePicker(Get.context!);
                },
              ),
              value: '1'),
        ],
      ),
    );
  }

  void _selectEndTimePicker(BuildContext context) async {
    await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    ).then((value) {
      String hour = value!.hour < 10 ? "0${value.hour}" : value.hour.toString();
      String minute =
          value.minute < 10 ? "0${value.minute}" : value.minute.toString();

      updateCardController.endTimePicker.value = "$hour:$minute";
      updateCardController.endDateTime.hour = value.hour;
      updateCardController.endDateTime.minute = value.minute;
    });
    Get.back();
  }

  _buildDropdownDateEndDate() {
    var datePicker = updateCardController.endDatePicker;
    return SizedBox(
      width: 540.w,
      child: DropdownButton(
        underline: Container(
          height: 1,
          color: Colors.black,
        ),
        isExpanded: true,
        hint: Text(
          Get.locale.toString() == "vi_VN"
              ? "Ngày ${datePicker.value.day} tháng ${datePicker.value.month}"
              : "${datePicker.value.day} thg ${datePicker.value.month}",
          style: TextStyle(color: Colors.black),
        ),
        onChanged: (dynamic value) {},
        items: [
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "today".tr,
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  updateCardController.endDatePicker.value = DateTime.now();
                  Get.back();
                },
              ),
              value: '1'),
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "tomorrow".tr,
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  updateCardController.endDatePicker.value =
                      DateTime.now().add(const Duration(days: 1));
                  Get.back();
                },
              ),
              value: '1'),
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "pick_a_date".tr,
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  _selectEndDate(Get.context!);
                },
              ),
              value: '1'),
        ],
      ),
    );
  }

  void _selectEndDate(BuildContext buildContext) async {
    await showDatePicker(
      context: buildContext,
      locale: Get.locale.toString() == "vi_VN"
          ? const Locale("vi", "VN")
          : const Locale("en", "US"),
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
    ).then((value) => updateCardController.endDatePicker.value = value!);
    Get.back();
  }

  _buildStartDate() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Icon(FontAwesomeIcons.clock),
        10.width,
        GestureDetector(
          onTap: () {
            Get.defaultDialog(
              contentPadding:
                  const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              radius: 2,
              title: "start_date".tr,
              content: Row(
                children: [
                  Obx(
                    () => _buildDropdownDateStartDate(),
                  ),
                  30.width,
                  Obx(
                    () => _buildDropdownTimeStartDate(),
                  ),
                ],
              ),
              cancel: GestureDetector(
                onTap: () {
                  Get.back();
                  // updateCardController.startDatePicker.value =
                  //     DateTime.now().add(const Duration(days: 1));
                  // updateCardController.startTimePicker.value = "9:00";
                  // updateCardController.startDateTime.hour = 9;
                  // updateCardController.startDateTime.minute = 0;
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 100, right: 20),
                  child: Text(
                    "cancel".tr,
                    style: const TextStyle(
                      color: Colors.blue,
                      letterSpacing: 3,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              confirm: GestureDetector(
                onTap: () {
                  updateCardController.updateCardStartDay();
                },
                child: Text(
                  "done".tr,
                  style: const TextStyle(
                    color: Colors.blue,
                    letterSpacing: 3,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
          child: Obx(
            () => Text(
              "${"start_date".tr}: ${DateFormat('dd-MM, kk:mm').format(updateCardController.startDatePicker.value)}",
              style: primaryTextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownTimeStartDate() {
    return SizedBox(
      width: 400.w,
      child: DropdownButton(
        underline: Container(
          height: 1,
          color: Colors.black,
        ),
        isExpanded: true,
        hint: Text(
          updateCardController.startTimePicker.value,
          style: primaryTextStyle(color: Colors.black),
        ),
        onChanged: (dynamic value) {},
        items: [
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "morning".tr,
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  updateCardController.startTimePicker.value = "09:00";
                  updateCardController.startDateTime.hour = 9;
                  Get.back();
                },
              ),
              value: '09:00'),
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "afternoon".tr,
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  updateCardController.startTimePicker.value = "13:00";
                  updateCardController.startDateTime.hour = 13;
                  Get.back();
                },
              ),
              value: '13:00'),
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "evening".tr,
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  updateCardController.startTimePicker.value = "17:00";
                  updateCardController.startDateTime.hour = 17;
                  Get.back();
                },
              ),
              value: '17:00'),
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "night".tr,
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  updateCardController.startTimePicker.value = "20:00";
                  updateCardController.startDateTime.hour = 20;
                  Get.back();
                },
              ),
              value: '20:00'),
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "pick_a_time".tr,
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  _selectStartTimePicker(Get.context!);
                },
              ),
              value: '1'),
        ],
      ),
    );
  }

  void _selectStartTimePicker(BuildContext context) async {
    await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    ).then((value) {
      String hour = value!.hour < 10 ? "0${value.hour}" : value.hour.toString();
      String minute =
          value.minute < 10 ? "0${value.minute}" : value.minute.toString();

      updateCardController.startTimePicker.value = "$hour:$minute";
      updateCardController.startDateTime.hour = value.hour;
      updateCardController.startDateTime.minute = value.minute;
    });
    Get.back();
  }

  _buildDropdownDateStartDate() {
    var datePicker = updateCardController.startDatePicker;
    return SizedBox(
      width: 540.w,
      child: DropdownButton(
        underline: Container(
          height: 1,
          color: Colors.black,
        ),
        isExpanded: true,
        hint: Text(
          Get.locale.toString() == "vi_VN"
              ? "Ngày ${datePicker.value.day} tháng ${datePicker.value.month}"
              : "${datePicker.value.day} thg ${datePicker.value.month}",
          style: const TextStyle(color: Colors.black),
        ),
        onChanged: (dynamic value) {},
        items: [
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "today".tr,
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  updateCardController.startDatePicker.value = DateTime.now();
                  Get.back();
                },
              ),
              value: '1'),
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "tomorrow".tr,
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  updateCardController.startDatePicker.value =
                      DateTime.now().add(
                    const Duration(days: 1),
                  );

                  Get.back();
                },
              ),
              value: '1'),
          DropdownMenuItem(
              child: ListTile(
                title: Text(
                  "pick_a_date".tr,
                  style: primaryTextStyle(color: Colors.black),
                ),
                onTap: () {
                  _selectStartDate(Get.context!);
                },
              ),
              value: '1'),
        ],
      ),
    );
  }

  void _selectStartDate(BuildContext context) async {
    await showDatePicker(
      context: context,
      locale: Get.locale.toString() == "vi_VN"
          ? const Locale("vi", "VN")
          : const Locale("en", "US"),
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
    ).then((value) {
      if (value != null) {
        updateCardController.startDatePicker.value = value;
      }
    });
    Get.back();
  }

  _buildMemberArea(BuildContext context) {
    return InkWell(
      onTap: () {
        openDialog(context).show();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.person_outline),
            SizedBox(
              width: 24.w,
            ),
            Obx(
              () => Expanded(
                child: Wrap(
                  runSpacing: 20.h,
                  spacing: 20.h,
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  children: updateCardController.cardUpdate.value.members
                      .map((userResponse) {
                    return Container(
                      width: 40,
                      height: 40,
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
            )
          ],
        ),
      ),
    );
  }

  dialog.AwesomeDialog openDialog(BuildContext context) {
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
              "card_members".tr,
              style: TextStyle(
                color: Colors.black,
                fontSize: 72.sp,
              ),
            ),
          ),
          Obx(
            () => ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: updateCardController.listMemberInBoard.length,
              itemBuilder: (_, index) {
                final userResponse =
                    updateCardController.listMemberInBoard[index];
                return InkWell(
                  onTap: () {
                    updateCardController
                        .handleClickListMember(userResponse.member_id);
                  },
                  child: ListTile(
                    leading: ClipOval(
                      child: CachedNetworkImage(
                        height: 50,
                        width: 50,
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
                    trailing: updateCardController
                            .memberIsExistInCard(userResponse.member_id)
                        ? const Icon(
                            Icons.check,
                            color: Colors.black,
                          )
                        : null,
                  ),
                );
              },
            ),
          )
        ],
      ),
      btnOkOnPress: () {},
    );
  }

  _buildQuickAction(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              updateCardController.isShowQuickActions.value =
                  !updateCardController.isShowQuickActions.value;
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "quick_actions".tr,
                  style: TextStyle(color: Colors.black, fontSize: 64.sp),
                ),
                Icon(
                  updateCardController.isShowQuickActions.isTrue
                      ? Icons.keyboard_arrow_up_sharp
                      : Icons.keyboard_arrow_down_sharp,
                  size: 36,
                  color: Colors.black,
                )
              ],
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Visibility(
            visible: updateCardController.isShowQuickActions.value,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          updateCardController.focusNode.requestFocus();
                          updateCardController.addingTask.value = true;
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.check_box_rounded,
                                    color: Colors.green),
                                SizedBox(
                                  width: 24.w,
                                ),
                                Text(
                                  "add_task".tr,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 56.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      flex: 12,
                    ),
                    Expanded(
                      child: Container(),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.attach_file_rounded,
                                  color: Colors.blue.shade600),
                              SizedBox(
                                width: 24.w,
                              ),
                              Text(
                                "add_attachment".tr,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 56.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      flex: 12,
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.w,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          await openDialog(context).show();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.person,
                                    color: Colors.purple.shade600),
                                SizedBox(
                                  width: 24.w,
                                ),
                                Text(
                                  "members".tr,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 56.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      flex: 12,
                    ),
                    Expanded(
                      child: Container(),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(),
                      flex: 12,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildListTasks() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: updateCardController.cardUpdate.value.tasks.isNotEmpty,
            child: updateCardController.cardUpdate.value.tasks.isNotEmpty
                ? StepProgressIndicator(
                    totalSteps:
                        updateCardController.cardUpdate.value.tasks.length,
                    currentStep: updateCardController.getLengthTaskIsComplete(),
                    selectedColor: Colors.blue,
                    unselectedColor: Colors.blue.shade100,
                  )
                : Container(),
          ),
          SizedBox(
            height: 20.h,
          ),
          ListView.separated(
            scrollDirection: Axis.vertical,
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: updateCardController.cardUpdate.value.tasks.length,
            itemBuilder: (_, index) {
              TaskResponse task =
                  updateCardController.cardUpdate.value.tasks[index];
              return Obx(() => _buildTask(task, index));
            },
            separatorBuilder: (_, index) {
              return Padding(
                padding: EdgeInsets.only(left: 64.w),
                child: const Divider(
                  color: Colors.black,
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              onTap: () {
                updateCardController.addingTask.value = true;
              },
              child: updateCardController.addingTask.isFalse
                  ? Text(
                      "${"add_task".tr}...",
                      style: TextStyle(color: Colors.grey, fontSize: 64.sp),
                    )
                  : TextFormField(
                      focusNode: updateCardController.focusNode,
                      minLines: 1,
                      style: TextStyle(color: Colors.black, fontSize: 64.sp),
                      maxLines: null,
                      autofocus: true,
                      controller: updateCardController.taskNameController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 2),
                        ),
                      ),
                      cursorColor: Colors.green,
                      cursorHeight: 25,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTask(TaskResponse task, int index) {
    updateCardController.listTaskNameController[index].text = task.name;
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            flex: 1,
            autoClose: false,
            onPressed: (_) {},
            backgroundColor: Colors.white,
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
          SlidableAction(
            flex: 1,
            autoClose: true,
            onPressed: (_) {
              updateCardController.deleteTask(task.task_id);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'delete'.tr,
          ),
        ],
      ),
      child: Row(
        children: [
          Checkbox(
            activeColor: Colors.green,
            checkColor: Colors.white,
            value: task.is_complete,
            onChanged: (value) {
              updateCardController.updateStatusTask(task, value!);
            },
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                updateCardController.taskIdSelected = task.task_id;
                updateCardController.editingTask.value = true;
                for (var element in updateCardController.listEditingTask) {
                  element = false;
                }
                updateCardController.listEditingTask[index] = true;
              },
              child: updateCardController.listEditingTask[index] == false
                  ? Text(
                      task.name,
                      style: task.is_complete
                          ? const TextStyle(
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey)
                          : const TextStyle(color: Colors.black),
                    )
                  : TextFormField(
                      style: TextStyle(color: Colors.black, fontSize: 64.sp),
                      autofocus: true,
                      controller:
                          updateCardController.listTaskNameController[index],
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      cursorColor: Colors.green,
                      cursorHeight: 25,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
