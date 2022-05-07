// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/card/card_request.dart';
import 'package:trellis_mobile_app/models/card/card_response.dart';
import 'package:trellis_mobile_app/models/member/board_member_detail_response.dart';
import 'package:trellis_mobile_app/models/member/card_member_request.dart';
import 'package:trellis_mobile_app/models/task/task_request.dart';
import 'package:trellis_mobile_app/models/task/task_response.dart';
import 'package:trellis_mobile_app/modules/dashboard/dashboard_controller.dart';
import 'package:trellis_mobile_app/modules/detail_board/detail_board_controller.dart';
import 'package:trellis_mobile_app/repository/card_repository.dart';
import 'package:trellis_mobile_app/repository/member_repository.dart';
import 'package:trellis_mobile_app/repository/task_repository.dart';

import '../../../models/my_date_time.dart';
import '../../../models/user/user_response.dart';

class UpdateCardController extends GetxController {
  final detailBoardController = Get.find<DetailBoardController>();
  final memberRepository = Get.find<MemberRepository>();
  final taskRepository = Get.find<TaskRepository>();
  final dashBoardController = Get.find<DashBoardController>();
  final cardNameController = TextEditingController();
  final cardDescriptionController = TextEditingController();
  final cardRepository = Get.find<CardRepository>();
  var cardUpdate = CardResponse(
    card_id: -1,
    name: "name",
    description: "description",
    position: -1,
    start_date: -1,
    due_date: -1,
    reminder: -1,
    list_id: -1,
    is_complete: false,
    created_time: -1,
    updated_time: -1,
    created_by: "",
    members: [],
    tasks: [],
  ).obs;

  var editingName = false.obs;
  var cardNameIsEmpty = false.obs;

  var editingDescription = false.obs;

  var startDatePicker = DateTime.now().add(const Duration(days: 1)).obs;
  var startTimePicker = "09:00".obs;
  var endDatePicker = DateTime.now().add(const Duration(days: 2)).obs;
  var endTimePicker = "09:00".obs;

  var reminderCode = 0.obs;

  var startDateTime =
      MyDateTime(year: -1, month: -1, day: -1, hour: 9, minute: 0);

  var endDateTime =
      MyDateTime(year: -1, month: -1, day: -1, hour: 9, minute: 0);

  var isAddMeToCard = true.obs;

  var listMemberInBoard = <BoardMemberDetailResponse>[].obs;

  var isShowQuickActions = true.obs;

  var addingTask = false.obs;
  var taskNameController = TextEditingController();

  var editingTask = false.obs;
  var listEditingTask = <bool>[].obs;
  var listTaskNameController = <TextEditingController>[].obs;

  var taskIdSelected = -1;

  late FocusNode focusNode;

  @override
  void onInit() {
    focusNode = FocusNode();
    initData();
    super.onInit();
  }

  void updateCardName() {
    EasyLoading.show(status: "please_wait".tr);
    var newCard = CardRequest(
      name: cardNameController.text.trim(),
      description: cardUpdate.value.description,
      position: cardUpdate.value.position,
      startDate: cardUpdate.value.start_date,
      dueDate: cardUpdate.value.due_date,
      reminder: cardUpdate.value.reminder,
      listId: cardUpdate.value.list_id,
      createdBy: cardUpdate.value.created_by,
    );

    cardRepository.updateCard(cardUpdate.value.card_id, newCard).then((value) {
      EasyLoading.dismiss();

      EasyLoading.showSuccess("update_success".tr);

      cardUpdate.value.name = value.name;

      editingName.value = false;

      detailBoardController.lists.refresh();
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          EasyLoading.dismiss();

          EasyLoading.showError("error".tr);
          break;
        default:
          EasyLoading.dismiss();

          EasyLoading.showError("error".tr);
          break;
      }
    });
  }

  void updateCardDescription() {
    EasyLoading.show(status: "please_wait".tr);
    var newCard = CardRequest(
      name: cardUpdate.value.name,
      description: cardDescriptionController.text.trim(),
      position: cardUpdate.value.position,
      startDate: cardUpdate.value.start_date,
      dueDate: cardUpdate.value.due_date,
      reminder: cardUpdate.value.reminder,
      listId: cardUpdate.value.list_id,
      createdBy: cardUpdate.value.created_by,
    );

    cardRepository.updateCard(cardUpdate.value.card_id, newCard).then((value) {
      EasyLoading.dismiss();

      EasyLoading.showSuccess("update_success".tr);

      cardUpdate.value.description = value.description;

      editingDescription.value = false;

      detailBoardController.lists.refresh();
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          EasyLoading.dismiss();

          EasyLoading.showError("error".tr);
          break;
        default:
          EasyLoading.dismiss();

          EasyLoading.showError("error".tr);
          break;
      }
    });
  }

  void updateCardStartDay() {
    updateDateTime();
    var startDate = DateTime(startDateTime.year, startDateTime.month,
        startDateTime.day, startDateTime.hour, startDateTime.minute, 0, 0);

    var endDate = DateTime(endDateTime.year, endDateTime.month, endDateTime.day,
        endDateTime.hour, endDateTime.minute, 0, 0);

    if (endDate.toUtc().millisecondsSinceEpoch <=
        startDate.toUtc().millisecondsSinceEpoch) {
      EasyLoading.showError("the_due_date_must_be_before_the_start_date".tr);
      return;
    }
    EasyLoading.show(status: "please_wait".tr);
    var newCard = CardRequest(
      name: cardUpdate.value.name,
      description: cardUpdate.value.description,
      position: cardUpdate.value.position,
      startDate: startDate.toUtc().millisecondsSinceEpoch,
      dueDate: cardUpdate.value.due_date,
      reminder: cardUpdate.value.reminder,
      listId: cardUpdate.value.list_id,
      createdBy: cardUpdate.value.created_by,
    );

    cardRepository.updateCard(cardUpdate.value.card_id, newCard).then((value) {
      EasyLoading.dismiss();

      EasyLoading.showSuccess("update_success".tr);

      startDatePicker.value =
          DateTime.fromMillisecondsSinceEpoch(value.start_date);

      cardUpdate.value.start_date = value.start_date;

      Get.back();

      detailBoardController.lists.refresh();
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          EasyLoading.dismiss();

          EasyLoading.showError("error".tr);
          break;
        default:
          EasyLoading.dismiss();

          EasyLoading.showError("error".tr);
          break;
      }
    });
  }

  void updateCardDueDate() {
    updateDateTime();
    var startDate = DateTime(startDateTime.year, startDateTime.month,
        startDateTime.day, startDateTime.hour, startDateTime.minute, 0, 0);

    var endDate = DateTime(endDateTime.year, endDateTime.month, endDateTime.day,
        endDateTime.hour, endDateTime.minute, 0, 0);

    var reminderDate = DateTime.now();

    switch (reminderCode.value) {
      case 0:
        reminderDate = DateTime.now();
        break;
      case 1:
        reminderDate = endDate.subtract(const Duration(minutes: 5));
        break;
      case 2:
        reminderDate = endDate.subtract(const Duration(minutes: 10));
        break;
      case 3:
        reminderDate = endDate.subtract(const Duration(minutes: 15));
        break;
      case 4:
        reminderDate = endDate.subtract(const Duration(hours: 1));
        break;
      case 5:
        reminderDate = endDate.subtract(const Duration(hours: 2));
        break;
      case 6:
        reminderDate = endDate.subtract(const Duration(days: 1));
        break;
      case 7:
        reminderDate = endDate.subtract(const Duration(days: 2));
        break;
      default:
        reminderDate = DateTime.now();
        break;
    }
    if (endDate.toUtc().millisecondsSinceEpoch <=
        startDate.toUtc().millisecondsSinceEpoch) {
      EasyLoading.showError("the_due_date_must_be_before_the_start_date".tr);
      return;
    }
    EasyLoading.show(status: "please_wait".tr);
    var newCard = CardRequest(
      name: cardUpdate.value.name,
      description: cardUpdate.value.description,
      position: cardUpdate.value.position,
      startDate: cardUpdate.value.due_date,
      dueDate: endDate.toUtc().millisecondsSinceEpoch,
      reminder: reminderDate.toUtc().millisecondsSinceEpoch,
      listId: cardUpdate.value.list_id,
      createdBy: cardUpdate.value.created_by,
    );

    cardRepository.updateCard(cardUpdate.value.card_id, newCard).then((value) {
      EasyLoading.dismiss();

      EasyLoading.showSuccess("update_success".tr);

      endDatePicker.value = DateTime.fromMillisecondsSinceEpoch(value.due_date);

      cardUpdate.value.due_date = value.due_date;
      cardUpdate.value.reminder = value.reminder;

      Get.back();

      detailBoardController.lists.refresh();
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          EasyLoading.dismiss();

          EasyLoading.showError("error".tr);
          break;
        default:
          EasyLoading.dismiss();

          EasyLoading.showError("error".tr);
          break;
      }
    });
  }

  void handleLeading() {
    if (editingName.isTrue) {
      editingName.value = false;
    } else if (editingDescription.isTrue) {
      editingDescription.value = false;
    } else if (addingTask.isTrue) {
      addingTask.value = false;
    } else if (editingTask.isTrue) {
      editingTask.value = false;
      for (int i = 0; i < listEditingTask.length; i++) {
        listEditingTask[i] = false;
      }
    } else {
      Get.back();
    }
  }

  void updateDateTime() {
    startDateTime.year = startDatePicker.value.year;
    startDateTime.month = startDatePicker.value.month;
    startDateTime.day = startDatePicker.value.day;

    endDateTime.year = endDatePicker.value.year;
    endDateTime.month = endDatePicker.value.month;
    endDateTime.day = endDatePicker.value.day;
  }

  String getReminderByCode(int code) {
    switch (code) {
      case 0:
        return "at_time_of_due_date".tr;
      case 1:
        return "5 ${"minutes_ago".tr}";
      case 2:
        return "10 ${"minutes_ago".tr}";
      case 3:
        return "15 ${"minutes_ago".tr}";
      case 4:
        return "1 ${"hours_ago".tr}";
      case 5:
        return "2 ${"hours_ago".tr}";
      case 6:
        return "1 ${"days_ago".tr}";
      case 7:
        return "2 ${"days_ago".tr}";
      default:
        return "at_time_of_due_date".tr;
    }
  }

  void initData() {
    cardUpdate.value = detailBoardController.selectedCard.value;
    cardNameController.text = cardUpdate.value.name;
    cardDescriptionController.text = cardUpdate.value.description;
    startDatePicker.value =
        DateTime.fromMillisecondsSinceEpoch(cardUpdate.value.start_date);
    endDatePicker.value =
        DateTime.fromMillisecondsSinceEpoch(cardUpdate.value.due_date);

    String startHour = startDatePicker.value.hour < 10
        ? "0${startDatePicker.value.hour}"
        : "${startDatePicker.value.hour}";
    String startMinute = startDatePicker.value.minute < 10
        ? "0${startDatePicker.value.minute}"
        : "${startDatePicker.value.minute}";

    startTimePicker.value = "$startHour: $startMinute";

    String endHour = endDatePicker.value.hour < 10
        ? "0${endDatePicker.value.hour}"
        : "${endDatePicker.value.hour}";
    String endMinute = endDatePicker.value.minute < 10
        ? "0${endDatePicker.value.minute}"
        : "${endDatePicker.value.minute}";
    endTimePicker.value = "${endHour}: ${endMinute}";

    var diff = endDatePicker.value
        .difference(
            DateTime.fromMillisecondsSinceEpoch(cardUpdate.value.reminder))
        .inMinutes;

    switch (diff) {
      case 0:
        reminderCode.value = 0;
        break;
      case 5:
        reminderCode.value = 1;
        break;
      case 10:
        reminderCode.value = 2;
        break;
      case 15:
        reminderCode.value = 3;
        break;
      case 60:
        reminderCode.value = 4;
        break;
      case 120:
        reminderCode.value = 5;
        break;
      case 1440:
        reminderCode.value = 6;
        break;
      case 2880:
        reminderCode.value = 7;
        break;
    }

    memberRepository
        .getListMemberInBoard(dashBoardController.boardIdSelected)
        .then((value) {
      listMemberInBoard.assignAll(value);
    });

    // init listEditingTask
    for (int i = 0; i < cardUpdate.value.tasks.length; i++) {
      listEditingTask.add(false);
    }

    for (int i = 0; i < cardUpdate.value.tasks.length; i++) {
      listTaskNameController.add(TextEditingController());
    }
  }

  bool memberIsExistInCard(String memberId) {
    for (UserResponse userResponse in cardUpdate.value.members) {
      if (userResponse.uid == memberId) {
        return true;
      }
    }
    return false;
  }

  void handleClickListMember(String uid) {
    EasyLoading.show(status: "please_wait".tr);
    if (memberIsExistInCard(uid)) {
      // remove member
      memberRepository
          .removeMemberInCard(uid, cardUpdate.value.card_id)
          .then((value) {
        cardUpdate.value.members.removeWhere((element) => element.uid == uid);
        cardUpdate.refresh();
        listMemberInBoard.refresh();
        detailBoardController.lists.refresh();
        EasyLoading.dismiss();
      }).catchError((Object obj) {
        switch (obj.runtimeType) {
          case DioError:
            // Here's the sample to get the failed response error code and message
            EasyLoading.dismiss();

            EasyLoading.showError("error".tr);
            break;
          default:
            EasyLoading.dismiss();

            EasyLoading.showError("error".tr);
            break;
        }
      });
    } else {
      memberRepository
          .createMemberIntoCard(CardMemberRequest(
              memberId: uid, cardId: cardUpdate.value.card_id))
          .then((value) {
        cardUpdate.value.members.add(value);
        cardUpdate.refresh();
        listMemberInBoard.refresh();
        detailBoardController.lists.refresh();
        EasyLoading.dismiss();
      }).catchError((Object obj) {
        switch (obj.runtimeType) {
          case DioError:
            // Here's the sample to get the failed response error code and message
            EasyLoading.dismiss();

            EasyLoading.showError("error".tr);
            break;
          default:
            EasyLoading.dismiss();

            EasyLoading.showError("error".tr);
            break;
        }
      });
    }
  }

  void addTask() {
    EasyLoading.show(status: "please_wait".tr);
    TaskRequest taskRequest = TaskRequest(
        name: taskNameController.text,
        position: cardUpdate.value.tasks.length,
        cardId: cardUpdate.value.card_id,
        isComplete: false,
        createdBy: dashBoardController.currentId);

    taskRepository.createTask(taskRequest).then((value) {
      EasyLoading.dismiss();

      EasyLoading.showSuccess("create_success".tr);

      cardUpdate.value.tasks.add(value);

      addingTask.value = false;

      taskNameController.clear();

      listEditingTask.add(false);
      listTaskNameController.add(TextEditingController());
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          EasyLoading.dismiss();

          EasyLoading.showError("error".tr);
          break;
        default:
          EasyLoading.dismiss();

          EasyLoading.showError("error".tr);
          break;
      }
    });
  }

  void updateStatusTask(TaskResponse task, bool isComplete) {
    EasyLoading.show(status: "please_wait".tr);

    TaskRequest taskRequest = TaskRequest(
        name: task.name,
        position: task.position,
        cardId: task.card_id,
        isComplete: isComplete,
        createdBy: dashBoardController.currentId);

    taskRepository.updateTask(task.task_id, taskRequest).then((value) {
      EasyLoading.dismiss();

      cardUpdate.value.tasks[findTaskIndexById(task.task_id)].is_complete =
          value.is_complete;

      cardUpdate.refresh();

      detailBoardController.lists.refresh();
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          EasyLoading.dismiss();

          EasyLoading.showError("error".tr);
          break;
        default:
          EasyLoading.dismiss();

          EasyLoading.showError("error".tr);
          break;
      }
    });
  }

  int findTaskIndexById(int taskId) {
    return cardUpdate.value.tasks
        .indexWhere((element) => element.task_id == taskId);
  }

  int getLengthTaskIsComplete() {
    int total = 0;
    cardUpdate.value.tasks.forEach(
      (element) {
        if (element.is_complete) {
          total++;
        }
      },
    );
    return total;
  }

  void updateTaskName(int taskId) {
    EasyLoading.show(status: "please_wait".tr);
    TaskResponse task = cardUpdate.value.tasks[findTaskIndexById(taskId)];
    TaskRequest taskRequest = TaskRequest(
        name: listTaskNameController[findTaskIndexById(taskId)].text,
        position: task.position,
        cardId: task.card_id,
        isComplete: task.is_complete,
        createdBy: dashBoardController.currentId);

    taskRepository.updateTask(taskId, taskRequest).then((value) {
      EasyLoading.dismiss();

      cardUpdate.value.tasks[findTaskIndexById(taskId)].name = value.name;

      listTaskNameController[findTaskIndexById(taskId)].clear();
      cardUpdate.refresh();

      editingTask.value = false;

      for (int i = 0; i < cardUpdate.value.tasks.length; i++) {
        listEditingTask[i] = false;
      }
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          EasyLoading.dismiss();

          EasyLoading.showError("error".tr);
          break;
        default:
          EasyLoading.dismiss();

          EasyLoading.showError("error".tr);
          break;
      }
    });
  }
}
