import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateCardController extends GetxController {
  var cardNameController = TextEditingController();
  var descriptionController = TextEditingController();
  var startDatePicker = DateTime.now().add(const Duration(days: 1)).obs;
  var endDatePicker = DateTime.now().add(const Duration(days: 1)).obs;
}
