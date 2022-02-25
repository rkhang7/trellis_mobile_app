import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/service/picker_service.dart';

class CreateCardController extends GetxController {
  var cardNameController = TextEditingController();
  var descriptionController = TextEditingController();
  var startDatePicker = DateTime.now().add(const Duration(days: 1)).obs;
  var startTimePicker = "09:00".obs;
  var endDatePicker = DateTime.now().add(const Duration(days: 1)).obs;
  var endTimePicker = "09:00".obs;

  var pickerService = Get.find<PickerService>();

  void printLog() {
    log("print log called");
  }

  pickImageFromCamera() {
    pickerService.pickImageFromCamera();
  }

  pickFile() {
    pickerService.pickFile();
  }
}
