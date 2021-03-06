import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/modules/card/create_card/create_card_controller.dart';
import 'package:trellis_mobile_app/modules/card/create_card/view/components/attach_item.dart';

import 'package:trellis_mobile_app/utils/colors.dart';
import 'package:trellis_mobile_app/utils/widget/input_field_create.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateCardPage extends StatelessWidget {
  CreateCardPage({Key? key}) : super(key: key);
  final createCardController = Get.find<CreateCardController>();
  var listId = Get.parameters["listId"];
  var listName = Get.parameters["listName"];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(16),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text("board".tr),
                //       _buildDropdownBoard(),
                //       30.height,
                //       Text("list".tr),
                //       _buildDropdownList(),
                //     ],
                //   ),
                // ),
                Container(
                  height: Get.height / 2.5,
                  width: Get.width,
                  color: backgroundColor,
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      height: Get.height / 2.5,
                      width: Get.width,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            InputFieldCreate(
                              onChange: (value) {
                                if (value.isEmpty) {
                                  createCardController.cardNameIsEmpty.value =
                                      true;
                                } else {
                                  createCardController.cardNameIsEmpty.value =
                                      false;
                                }
                              },
                              title: "card_name".tr,
                              controller:
                                  createCardController.cardNameController,
                              autoFocus: false,
                              primaryColor: Colors.green,
                            ),
                            InputFieldCreate(
                                onChange: (value) {},
                                title: "desc".tr,
                                controller:
                                    createCardController.descriptionController,
                                autoFocus: false,
                                primaryColor: Colors.green),
                            10.height,
                            5.height,
                            _buildStartDate(),
                            10.height,
                            _buildEndDate(),
                            20.height,
                            // _buildAttachment(),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      leading: const CloseButton(),
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "${'add_card'.tr} ${'into_the'.tr} ",
              style: boldTextStyle(
                color: Colors.white,
                size: 18,
              ),
            ),
            TextSpan(
              text: "$listName",
              style: boldTextStyle(
                color: Colors.white,
                size: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Obx(() => _buildAction()),
      ],
    );
  }

  Widget _buildAction() {
    return IconButton(
      onPressed: () {
        createCardController.cardNameIsEmpty.isTrue
            ? null
            : createCardController.createCard(int.parse(listId!));
      },
      icon: Icon(
        Icons.check,
        color: createCardController.cardNameIsEmpty.isTrue
            ? Colors.grey
            : Colors.white,
      ),
    );
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
                  createCardController.startDatePicker.value =
                      DateTime.now().add(const Duration(days: 1));
                  createCardController.startTimePicker.value = "9:00";
                  createCardController.startDateTime.hour = 9;
                  createCardController.startDateTime.minute = 0;
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 100, right: 20),
                  child: Text(
                    "cancel".tr,
                    style: const TextStyle(
                      color: Colors.blue,
                      letterSpacing: 3,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              confirm: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  "done".tr,
                  style: const TextStyle(
                    color: Colors.blue,
                    letterSpacing: 3,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
          child: Text(
            "${"start_date".tr}...",
            style: primaryTextStyle(color: Colors.black),
          ),
        ),
      ],
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
                  Obx(() {
                    return CheckboxListTile(
                      contentPadding: const EdgeInsets.all(0),
                      value: createCardController.isAddMeToCard.isTrue
                          ? true
                          : false,
                      onChanged: (value) {
                        createCardController.isAddMeToCard.value =
                            !createCardController.isAddMeToCard.value;
                      },
                      title: const Text(
                        "Th??m t??i v??o th???",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    );
                  })
                ],
              ),
              cancel: GestureDetector(
                onTap: () {
                  Get.back();
                  createCardController.reminderCode.value = 0;
                  createCardController.endDatePicker.value =
                      DateTime.now().add(const Duration(days: 2));
                  createCardController.endTimePicker.value = "9:00";
                  createCardController.endDateTime.hour = 9;
                  createCardController.endDateTime.minute = 0;
                  createCardController.isAddMeToCard.value = true;
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 100, right: 20),
                  child: Text(
                    "cancel".tr,
                    style: const TextStyle(
                      color: Colors.blue,
                      letterSpacing: 3,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              confirm: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  "done".tr,
                  style: const TextStyle(
                    color: Colors.blue,
                    letterSpacing: 3,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
          child: Text(
            "${"due_date".tr}...",
            style: primaryTextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  _buildDropdownDateStartDate() {
    var datePicker = createCardController.startDatePicker;
    return SizedBox(
      width: 600.w,
      child: DropdownButton(
        underline: Container(
          height: 1,
          color: Colors.black,
        ),
        isExpanded: true,
        hint: Text(
          Get.locale.toString() == "vi_VN"
              ? "Ng??y ${datePicker.value.day} th??ng ${datePicker.value.month}"
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
                  createCardController.startDatePicker.value = DateTime.now();
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
                  createCardController.startDatePicker.value =
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
          createCardController.startTimePicker.value,
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
                  createCardController.startTimePicker.value = "09:00";
                  createCardController.startDateTime.hour = 9;
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
                  createCardController.startTimePicker.value = "13:00";
                  createCardController.startDateTime.hour = 13;
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
                  createCardController.startTimePicker.value = "17:00";
                  createCardController.startDateTime.hour = 17;
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
                  createCardController.startTimePicker.value = "20:00";
                  createCardController.startDateTime.hour = 20;
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

  _buildDropdownDateEndDate() {
    var datePicker = createCardController.endDatePicker;
    return SizedBox(
      width: 600.w,
      child: DropdownButton(
        underline: Container(
          height: 1,
          color: Colors.black,
        ),
        isExpanded: true,
        hint: Text(
          Get.locale.toString() == "vi_VN"
              ? "Ng??y ${datePicker.value.day} th??ng ${datePicker.value.month}"
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
                  createCardController.endDatePicker.value = DateTime.now();
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
                  createCardController.endDatePicker.value =
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
          createCardController.endTimePicker.value,
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
                  createCardController.endTimePicker.value = "09:00";
                  createCardController.endDateTime.hour = 9;

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
                  createCardController.endTimePicker.value = "13:00";
                  createCardController.endDateTime.hour = 13;

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
                  createCardController.endTimePicker.value = "17:00";
                  createCardController.endDateTime.hour = 17;
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
                  createCardController.endTimePicker.value = "20:00";
                  createCardController.endDateTime.hour = 20;
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

  Widget _buildDropdownRemind() {
    return DropdownButton<int>(
      underline: Container(
        height: 1,
        color: Colors.black,
      ),
      isExpanded: true,
      hint: Text(
        createCardController
            .getReminderByCode(createCardController.reminderCode.value),
        style: const TextStyle(color: Colors.black),
      ),
      onChanged: (dynamic value) {
        createCardController.reminderCode.value = value;
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
        createCardController.startDatePicker.value = value;
      }
    });
    Get.back();
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
    ).then((value) => createCardController.endDatePicker.value = value!);
    Get.back();
  }

  void _selectStartTimePicker(BuildContext context) async {
    await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    ).then((value) {
      String hour = value!.hour < 10 ? "0${value.hour}" : value.hour.toString();
      String minute =
          value.minute < 10 ? "0${value.minute}" : value.minute.toString();

      createCardController.startTimePicker.value = "$hour:$minute";
      createCardController.startDateTime.hour = value.hour;
      createCardController.startDateTime.minute = value.minute;
    });
    Get.back();
  }

  void _selectEndTimePicker(BuildContext context) async {
    await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    ).then((value) {
      String hour = value!.hour < 10 ? "0${value.hour}" : value.hour.toString();
      String minute =
          value.minute < 10 ? "0${value.minute}" : value.minute.toString();

      createCardController.endTimePicker.value = "$hour:$minute";
      createCardController.endDateTime.hour = value.hour;
      createCardController.endDateTime.minute = value.minute;
    });
    Get.back();
  }

  // _buildAttachment() {
  //   return Row(
  //     children: [
  //       const Icon(Icons.attach_file),
  //       10.width,
  //       GestureDetector(
  //         onTap: () {
  //           Get.defaultDialog(
  //               radius: 5,
  //               title: "attach_from".tr,
  //               contentPadding:
  //                   const EdgeInsets.only(left: 24, top: 12, right: 24),
  //               content: Column(
  //                 children: [
  //                   AttachItem(
  //                     icon: Icons.camera_alt_outlined,
  //                     title: "camera".tr,
  //                     onClick: () {
  //                       createCardController.pickImageFromCamera();
  //                     },
  //                   ),
  //                   30.height,
  //                   AttachItem(
  //                     icon: Icons.attach_file,
  //                     title: "file".tr,
  //                     onClick: () {
  //                       createCardController.pickFile();
  //                     },
  //                   ),
  //                   30.height,
  //                   AttachItem(
  //                     icon: FontAwesomeIcons.externalLinkAlt,
  //                     title: "attach_link".tr,
  //                     onClick: () {},
  //                   ),
  //                   30.height,
  //                   AttachItem(
  //                     icon: Icons.table_chart_outlined,
  //                     title: "Trello",
  //                     onClick: () {},
  //                   ),
  //                 ],
  //               ));
  //         },
  //         child: Text(
  //           "${"attachment".tr}...",
  //           style: primaryTextStyle(color: Colors.black),
  //         ),
  //       )
  //     ],
  //   );
  // }
}
