import 'package:get/get.dart';

class CreateTableController extends GetxController {
  var itemDropDownList = [];
  var selected = "".obs;

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
