// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/card/card_request.dart';
import 'package:trellis_mobile_app/models/card/card_response.dart';
import 'package:trellis_mobile_app/modules/detail_board/detail_board_controller.dart';
import 'package:trellis_mobile_app/repository/card_repository.dart';

import '../../../models/my_date_time.dart';

class UpdateCardController extends GetxController {
  final detailBoardController = Get.find<DetailBoardController>();
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
      members: []).obs;

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

  @override
  void onInit() {
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

  void handleLeading() {
    if (editingName.isTrue) {
      editingName.value = false;
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
}
