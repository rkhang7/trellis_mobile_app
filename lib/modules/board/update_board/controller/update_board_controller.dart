import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/modules/board/board_menu/controller/board_menu_controller.dart';

class UpdateBoardController extends GetxController {
  var boardNameController = TextEditingController();
  var descriptionController = TextEditingController();
  var boardNameIsEmpty = false.obs;
  var selectedType = 1.obs;

  final boardMenuController = Get.find<BoardMenuController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void initData() {
    boardNameController.text = boardMenuController.currentBoard!.name;
    descriptionController.text = boardMenuController.currentBoard!.description;
    selectedType.value = boardMenuController.currentBoard!.visibility;
  }
}
