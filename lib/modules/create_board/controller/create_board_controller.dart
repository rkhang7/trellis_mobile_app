import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateBoardController extends GetxController {
  var itemDropDownList = [];
  var selected = "".obs;
  var boardNameController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initItemDropDownList();
    selected.value = itemDropDownList[0];
  }

  void initItemDropDownList() {
    itemDropDownList = ["Nhóm 1, Nhóm 2, Nhóm 3"];
  }

  void setSelected(String value) {
    selected.value = value;
  }
}
