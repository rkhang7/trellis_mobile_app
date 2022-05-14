import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:trellis_mobile_app/models/card/card_request.dart';
import 'package:trellis_mobile_app/models/member/card_member_request.dart';
import 'package:trellis_mobile_app/models/my_date_time.dart';
import 'package:trellis_mobile_app/models/user/user_response.dart';
import 'package:trellis_mobile_app/modules/dashboard/dashboard_controller.dart';
import 'package:trellis_mobile_app/modules/detail_board/detail_board_controller.dart';
import 'package:trellis_mobile_app/repository/card_repository.dart';
import 'package:trellis_mobile_app/repository/member_repository.dart';
import 'package:trellis_mobile_app/repository/user_repository.dart';
import 'package:trellis_mobile_app/service/picker_service.dart';

class CreateCardController extends GetxController {
  final pickerService = Get.find<PickerService>();
  final cardRepository = Get.find<CardRepository>();
  final userRepository = Get.find<UserRepository>();
  final memberRepository = Get.find<MemberRepository>();
  final detailBoardController = Get.find<DetailBoardController>();
  final dashBoardController = Get.find<DashBoardController>();

  var cardNameController = TextEditingController();
  var cardNameIsEmpty = true.obs;
  var descriptionController = TextEditingController();
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

  @override
  void onInit() {
    updateDateTime();
    super.onInit();
  }

  void pickImageFromCamera() {
    pickerService.pickImageFromCamera();
  }

  void pickFile() {
    pickerService.pickFile();
  }

  void createCard(int listId) {
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
    int lengthListCard =
        detailBoardController.findListById(listId).cards.length;
    EasyLoading.show(status: "please_wait".tr);
    String cardName = cardNameController.text;
    String description = descriptionController.text;
    CardRequest cardRequest = CardRequest(
      name: cardName,
      description: description,
      position: lengthListCard,
      startDate: startDate.toUtc().millisecondsSinceEpoch,
      dueDate: endDate.toUtc().millisecondsSinceEpoch,
      reminder: reminderDate.toUtc().millisecondsSinceEpoch,
      listId: listId,
      createdBy: dashBoardController.currentId,
      isComplete: false,
    );

    cardRepository.createCard(cardRequest).then((value) {
      // insert to first index list workspace

      detailBoardController
          .lists[detailBoardController.findIndexListById(listId)].cards
          .add(value);

      if (isAddMeToCard.isTrue) {
        memberRepository
            .createMemberIntoCard(CardMemberRequest(
                memberId: dashBoardController.currentId, cardId: value.card_id))
            .then((value) {
          EasyLoading.dismiss();

          EasyLoading.showSuccess("create_success".tr);

          int listIndex = detailBoardController.findIndexListById(listId);
          int lenghtCurrentCard =
              detailBoardController.lists[listIndex].cards.length;
          detailBoardController
              .lists[listIndex].cards[lenghtCurrentCard - 1].members
              .add(value);

          detailBoardController.lists.refresh();

          Get.back();
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
        EasyLoading.dismiss();

        EasyLoading.showSuccess("create_success".tr);

        detailBoardController.lists.refresh();

        Get.back();
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
}
