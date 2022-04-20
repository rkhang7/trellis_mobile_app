import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:trellis_mobile_app/models/card/card_request.dart';
import 'package:trellis_mobile_app/models/my_date_time.dart';
import 'package:trellis_mobile_app/modules/dashboard/dashboard_controller.dart';
import 'package:trellis_mobile_app/modules/detail_board/detail_board_controller.dart';
import 'package:trellis_mobile_app/repository/card_repository.dart';
import 'package:trellis_mobile_app/service/picker_service.dart';

class CreateCardController extends GetxController {
  final pickerService = Get.find<PickerService>();
  final cardRepository = Get.find<CardRepository>();
  final detailBoardController = Get.find<DetailBoardController>();
  final dashBoardController = Get.find<DashBoardController>();

  var cardNameController = TextEditingController();
  var cardNameIsEmpty = true.obs;
  var descriptionController = TextEditingController();
  var startDatePicker = DateTime.now().add(const Duration(days: 1)).obs;
  var startTimePicker = "09:00".obs;
  var endDatePicker = DateTime.now().add(const Duration(days: 2)).obs;
  var endTimePicker = "09:00".obs;

  var startDateTime =
      MyDateTime(year: -1, month: -1, day: -1, hour: 9, minute: 0);

  var endDateTime =
      MyDateTime(year: -1, month: -1, day: -1, hour: 9, minute: 0);

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
      listId: listId,
      createdBy: dashBoardController.currentId,
    );

    cardRepository.creatCard(cardRequest).then((value) {
      EasyLoading.dismiss();

      EasyLoading.showSuccess("create_success".tr);

      // insert to first index list workspace

      detailBoardController
          .lists[detailBoardController.findIndexListById(listId)].cards
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
  }

  void updateDateTime() {
    startDateTime.year = startDatePicker.value.year;
    startDateTime.month = startDatePicker.value.month;
    startDateTime.day = startDatePicker.value.day;

    endDateTime.year = endDatePicker.value.year;
    endDateTime.month = endDatePicker.value.month;
    endDateTime.day = endDatePicker.value.day;
  }
}
