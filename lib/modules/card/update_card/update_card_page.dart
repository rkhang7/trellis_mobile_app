import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:trellis_mobile_app/models/file/file_response.dart';
import 'package:trellis_mobile_app/models/task/task_response.dart';
import 'package:trellis_mobile_app/modules/card/create_card/view/components/attach_item.dart';
import 'package:trellis_mobile_app/modules/card/update_card/update_card_controller.dart';
import 'package:awesome_dialog/awesome_dialog.dart' as dialog;
import 'package:trellis_mobile_app/routes/app_routes.dart';

class UpdateCardPage extends StatefulWidget {
  UpdateCardPage({Key? key}) : super(key: key);

  @override
  State<UpdateCardPage> createState() => _UpdateCardPageState();
}

class _UpdateCardPageState extends State<UpdateCardPage> {
  final updateCardController = Get.find<UpdateCardController>();
  List<TaskInfo>? _tasks;

  late bool _isLoading;
  late bool _permissionReady;
  late String _localPath;
  final ReceivePort _port = ReceivePort();
  @override
  void initState() {
    super.initState();

    _bindBackgroundIsolate();

    FlutterDownloader.registerCallback(downloadCallback);

    _isLoading = true;
    _permissionReady = false;

    _prepare();
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

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
              _buildCardInList(),
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
              // _buildLabels(context),
              // SizedBox(
              //   height: 50.h,
              // ),
              _buildMemberArea(context),
              SizedBox(
                height: 50.h,
              ),
              Obx(
                () => _buildImageArea(),
              ),

              Obx(
                () => _buildFileArea(),
              ),

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

  Widget _buildDownloadList() => Container(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: updateCardController.items
              .map((item) => item.task == null
                  ? _buildListSection(item.name!)
                  : DownloadItem(
                      data: item,
                      onItemClick: (task) {
                        _openDownloadedFile(task).then((success) {
                          if (!success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Cannot open this file'),
                              ),
                            );
                          }
                        });
                      },
                      onActionClick: (task) {
                        if (task.status == DownloadTaskStatus.undefined) {
                          _requestDownload(task);
                        } else if (task.status == DownloadTaskStatus.running) {
                          _pauseDownload(task);
                        } else if (task.status == DownloadTaskStatus.paused) {
                          _resumeDownload(task);
                        } else if (task.status == DownloadTaskStatus.complete) {
                          _delete(task);
                        } else if (task.status == DownloadTaskStatus.failed) {
                          _retryDownload(task);
                        }
                      },
                    ))
              .toList(),
        ),
      );

  Widget _buildListSection(String title) => Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue,
          fontSize: 18,
          overflow: TextOverflow.visible,
        ),
      ));
  Future<bool> _openDownloadedFile(TaskInfo? task) {
    if (task != null) {
      return FlutterDownloader.open(taskId: task.taskId!);
    } else {
      return Future.value(false);
    }
  }

  void _delete(TaskInfo task) async {
    await FlutterDownloader.remove(
        taskId: task.taskId!, shouldDeleteContent: true);
    await _prepare();
    setState(() {});
  }

  void _requestDownload(TaskInfo task) async {
    task.taskId = await FlutterDownloader.enqueue(
      url: task.link!,
      headers: {"auth": "test_for_sql_encoding"},
      savedDir: _localPath,
      showNotification: true,
      openFileFromNotification: true,
      saveInPublicStorage: true,
    );
  }

  // Not used in the example.
  // void _cancelDownload(_TaskInfo task) async {
  //   await FlutterDownloader.cancel(taskId: task.taskId!);
  // }

  void _pauseDownload(TaskInfo task) async {
    await FlutterDownloader.pause(taskId: task.taskId!);
  }

  void _resumeDownload(TaskInfo task) async {
    String? newTaskId = await FlutterDownloader.resume(taskId: task.taskId!);
    task.taskId = newTaskId;
  }

  void _retryDownload(TaskInfo task) async {
    String? newTaskId = await FlutterDownloader.retry(taskId: task.taskId!);
    task.taskId = newTaskId;
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      String? id = data[0];
      DownloadTaskStatus? status = data[1];
      int? progress = data[2];

      if (_tasks != null && _tasks!.isNotEmpty) {
        final task = _tasks!.firstWhere((task) => task.taskId == id);
        setState(() {
          task.status = status;
          task.progress = progress;
        });
      }
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  Future<void> _prepare() async {
    final tasks = await FlutterDownloader.loadTasks();

    int count = 0;
    _tasks = [];
    updateCardController.items.value = [];
    updateCardController.getListDocument().length;
    _tasks!.addAll(
      updateCardController.getListDocument().map(
            (file) => TaskInfo(name: file.name, link: file.url),
          ),
    );

    for (int i = 0; i < _tasks!.length; i++) {
      updateCardController.items
          .add(ItemHolder(name: _tasks![i].name, task: _tasks![i]));
      count++;
    }

    for (var task in tasks!) {
      for (TaskInfo info in _tasks!) {
        if (info.link == task.url) {
          info.taskId = task.taskId;
          info.status = task.status;
          info.progress = task.progress;
        }
      }
    }

    _permissionReady = await _checkPermission();

    if (_permissionReady) {
      await _prepareSaveDir();
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    String? externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }

  Future<bool> _checkPermission() async {
    if (Platform.isIOS) return true;

    // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (true) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    }
    return false;
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
                        fontSize: 12,
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
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
            child: Obx(
              () => Text(
                "${"due_date".tr}: ${DateFormat('dd-MM-yyyy, kk:mm').format(updateCardController.endDatePicker.value)}",
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
      width: 560.w,
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
                      fontSize: 12,
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
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
          child: Obx(
            () => Text(
              "${"start_date".tr}: ${DateFormat('dd-MM-yyyy, kk:mm').format(updateCardController.startDatePicker.value)}",
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
      width: 560.w,
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
                        .handleClickListMember(userResponse.memberId);
                  },
                  child: ListTile(
                    leading: ClipOval(
                      child: CachedNetworkImage(
                        height: 50,
                        width: 50,
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
                    trailing: updateCardController
                            .memberIsExistInCard(userResponse.memberId)
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

  dialog.AwesomeDialog openDialogLabel(BuildContext context) {
    return dialog.AwesomeDialog(
      context: context,
      animType: dialog.AnimType.SCALE,
      dialogType: dialog.DialogType.NO_HEADER,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(left: 18),
          //   child: Text(
          //     "card_members".tr,
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontSize: 72.sp,
          //     ),
          //   ),
          // ),
          Obx(
            () => ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: updateCardController.listLabel.length,
              itemBuilder: (_, index) {
                final label = updateCardController.listLabel[index];
                return InkWell(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 40,
                    decoration: BoxDecoration(
                      color: HexColor(label.color),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            label.name,
                            style:
                                TextStyle(color: Colors.white, fontSize: 81.sp),
                          ),
                          updateCardController
                                      .labelIsExistInCard(label.labelId) ==
                                  true
                              ? const Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                )
                              : Container(),
                        ],
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
                      child: InkWell(
                        onTap: () {
                          Get.defaultDialog(
                            radius: 5,
                            title: "attach_from".tr,
                            contentPadding: const EdgeInsets.only(
                                left: 24, top: 12, right: 24),
                            content: Column(
                              children: [
                                AttachItem(
                                  icon: Icons.camera_alt_outlined,
                                  title: "camera".tr,
                                  onClick: () {
                                    updateCardController.pickImageFromCamera();
                                  },
                                ),
                                // 30.height,
                                // AttachItem(
                                //   icon: Icons.album_outlined,
                                //   title: "gallery".tr,
                                //   onClick: () {
                                //     updateCardController.pickImageFromGallery();
                                //   },
                                // ),
                                30.height,
                                AttachItem(
                                  icon: Icons.attach_file,
                                  title: "file".tr,
                                  onClick: () {
                                    updateCardController.pickFile();
                                  },
                                ),
                              ],
                            ),
                          );
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
          ReorderableListView.builder(
            scrollDirection: Axis.vertical,
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: updateCardController.cardUpdate.value.tasks.length,
            itemBuilder: (_, index) {
              TaskResponse task =
                  updateCardController.cardUpdate.value.tasks[index];
              return _buildTask(task, index);
            },
            onReorder: (int oldIndex, int newIndex) {
              swapTasks(updateCardController.cardUpdate.value.tasks, oldIndex,
                  newIndex);
            },
            // separatorBuilder: (_, index) {
            //   return Padding(
            //     padding: EdgeInsets.only(left: 64.w),
            //     child: const Divider(
            //       color: Colors.black,
            //     ),
            //   );
            // },
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
    return Container(
      key: ValueKey(task.taskId),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
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
                updateCardController.deleteTask(task.taskId);
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
              value: task.isComplete,
              onChanged: (value) {
                updateCardController.updateStatusTask(task, value!);
              },
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  updateCardController.taskIdSelected = task.taskId;
                  updateCardController.editingTask.value = true;
                  for (var element in updateCardController.listEditingTask) {
                    element = false;
                  }
                  updateCardController.listEditingTask[index] = true;
                },
                child: updateCardController.listEditingTask[index] == false
                    ? Text(
                        task.name,
                        style: task.isComplete
                            ? const TextStyle(
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              )
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
      ),
    );
  }

  void swapTasks(List<TaskResponse> listTasks, int oldIndex, int newIndex) {
    updateCardController.moveTask(
        updateCardController.cardUpdate.value.cardId, oldIndex, newIndex);
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final TaskResponse item = listTasks.removeAt(oldIndex);
    listTasks.insert(newIndex, item);
  }

  _buildLabels(BuildContext context) {
    return InkWell(
      onTap: () {
        openDialogLabel(context).show();
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.label_important_outline),
            SizedBox(width: 80.w),
            updateCardController.cardUpdate.value.labels.isEmpty
                ? Text(
                    "label".tr,
                    style: TextStyle(color: Colors.black, fontSize: 64.sp),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  _buildCardInList() {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 8),
        color: Colors.white,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "in_list".tr,
                style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontSize: 64.sp,
                ),
              ),
              TextSpan(
                text: " ${updateCardController.cardUpdate.value.listName}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 64.sp,
                ),
              ),
            ],
          ),
        ));
  }

  _buildImageArea() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.image_outlined),
              SizedBox(width: 80.w),
              Text(
                "${"image".tr} (${updateCardController.cardUpdate.value.cardAttachments.where((element) => element.url.isImage).length})",
                style: TextStyle(color: Colors.black, fontSize: 64.sp),
              )
            ],
          ),
          updateCardController.cardUpdate.value.cardAttachments.isNotEmpty
              ? Container(
                  height: 100,
                  width: 500,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: updateCardController
                        .cardUpdate.value.cardAttachments.length,
                    itemBuilder: (context, index) {
                      FileResponse fileResponse = updateCardController
                          .cardUpdate.value.cardAttachments[index];

                      if (fileResponse.url.isImage) {
                        return Container(
                          padding: EdgeInsets.all(8),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(
                                AppRoutes.VIEW_IMAGE,
                                arguments: fileResponse.url,
                              );
                            },
                            child: CachedNetworkImage(
                              imageUrl: fileResponse.url,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) {
                                return const Icon(Icons.error);
                              },
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildNoPermissionWarning() => Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Please grant accessing storage permission to continue -_-',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),
                ),
              ),
              const SizedBox(
                height: 32.0,
              ),
              TextButton(
                  onPressed: () {
                    _retryRequestPermission();
                  },
                  child: const Text(
                    'Retry',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ))
            ],
          ),
        ),
      );

  Future<void> _retryRequestPermission() async {
    final hasGranted = await _checkPermission();

    if (hasGranted) {
      await _prepareSaveDir();
    }

    setState(() {
      _permissionReady = hasGranted;
    });
  }

  _buildFileArea() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.file_copy_outlined),
              SizedBox(width: 80.w),
              Text(
                "${"file".tr} (${updateCardController.cardUpdate.value.cardAttachments.where((element) => !element.url.isImage).length})",
                style: TextStyle(color: Colors.black, fontSize: 64.sp),
              )
            ],
          ),
          updateCardController.cardUpdate.value.cardAttachments.isNotEmpty
              ? Container(
                  height: 200,
                  width: 500,
                  child: Builder(
                      builder: (context) => _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : _permissionReady
                              ? _buildDownloadList()
                              : _buildNoPermissionWarning()),
                )
              : Container(),
        ],
      ),
    );
  }
}

class TaskInfo {
  final String? name;
  final String? link;

  String? taskId;
  int? progress = 0;
  DownloadTaskStatus? status = DownloadTaskStatus.undefined;

  TaskInfo({this.name, this.link});
}

class ItemHolder {
  final String? name;
  final TaskInfo? task;

  ItemHolder({this.name, this.task});
}

class DownloadItem extends StatelessWidget {
  final ItemHolder? data;
  final Function(TaskInfo?)? onItemClick;
  final Function(TaskInfo)? onActionClick;

  DownloadItem({this.data, this.onItemClick, this.onActionClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 8.0),
      child: InkWell(
        onTap: data!.task!.status == DownloadTaskStatus.complete
            ? () {
                onItemClick!(data!.task);
              }
            : null,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 64.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      data!.name!,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: _buildActionForTask(data!.task!),
                  ),
                ],
              ),
            ),
            data!.task!.status == DownloadTaskStatus.running ||
                    data!.task!.status == DownloadTaskStatus.paused
                ? Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: LinearProgressIndicator(
                      value: data!.task!.progress! / 100,
                    ),
                  )
                : Container()
          ].toList(),
        ),
      ),
    );
  }

  Widget? _buildActionForTask(TaskInfo task) {
    if (task.status == DownloadTaskStatus.undefined) {
      return RawMaterialButton(
        onPressed: () {
          onActionClick!(task);
        },
        child: const Icon(Icons.file_download),
        shape: const CircleBorder(),
        constraints: const BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.running) {
      return RawMaterialButton(
        onPressed: () {
          onActionClick!(task);
        },
        child: const Icon(
          Icons.pause,
          color: Colors.red,
        ),
        shape: CircleBorder(),
        constraints: const BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.paused) {
      return RawMaterialButton(
        onPressed: () {
          onActionClick!(task);
        },
        child: const Icon(
          Icons.play_arrow,
          color: Colors.green,
        ),
        shape: const CircleBorder(),
        constraints: const BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.complete) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'open'.tr,
            style: const TextStyle(color: Colors.green),
          ),
          RawMaterialButton(
            onPressed: () {
              onActionClick!(task);
            },
            child: const Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
            shape: const CircleBorder(),
            constraints: const BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          )
        ],
      );
    } else if (task.status == DownloadTaskStatus.canceled) {
      return Text('canceled'.tr, style: TextStyle(color: Colors.red));
    } else if (task.status == DownloadTaskStatus.failed) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('failed'.tr, style: const TextStyle(color: Colors.red)),
          RawMaterialButton(
            onPressed: () {
              onActionClick!(task);
            },
            child: const Icon(
              Icons.refresh,
              color: Colors.green,
            ),
            shape: const CircleBorder(),
            constraints: const BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          )
        ],
      );
    } else if (task.status == DownloadTaskStatus.enqueued) {
      return Text('pending'.tr, style: TextStyle(color: Colors.orange));
    } else {
      return null;
    }
  }
}
