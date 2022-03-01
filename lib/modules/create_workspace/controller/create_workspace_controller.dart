import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/core/board_model.dart';

class CreateWorkspaceController extends GetxController {
  var workspaceNameController = TextEditingController();
  var workspaceNameIsEmpty = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
