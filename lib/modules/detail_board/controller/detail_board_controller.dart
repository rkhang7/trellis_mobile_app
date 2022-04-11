import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/list/list_response.dart';
import 'package:trellis_mobile_app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:trellis_mobile_app/repository/list_repository.dart';

class DetailBoardController extends GetxController {
  final listRepository = Get.find<ListRepository>();
  var dashBoardController = Get.find<DashBoardController>();
  var pageController = PageController(viewportFraction: 0.8);
  var listCardScrollController = <ScrollController>[];

  var lists = <ListResponse>[].obs;
  var nameListEditing = false.obs; // appBar
  var listNameListEditing = <bool>[].obs; // item
  var listController = <TextEditingController>[];
  var nameListIsEmpty = false.obs;

  // add card
  var nameCardAdding = false.obs; // appBar
  var listNameCardAdding = <bool>[].obs; // item
  var listNameCardController = <TextEditingController>[];
  var nameCardIsEmpty = false.obs;

  // add list
  var nameListAdding = false.obs;
  var nameListAddingController = TextEditingController();

  @override
  void onInit() {
    initData();

    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    pageController.dispose();
  }

  void initData() async {
    await listRepository
        .getListsInBoard(dashBoardController.boardIdSelected)
        .then((value) {
      lists.assignAll(value);

      initListController();
      initListEditing();
      initListNameCardController();
      initListNameCardAdding();
      initListCardScrollController();
    });
  }

  void initListController() {
    for (int i = 0; i < lists.length; i++) {
      listController.add(TextEditingController());
    }
  }

  void initListEditing() {
    for (int i = 0; i < lists.length; i++) {
      listNameListEditing.add(false);
    }
  }

  void initListNameCardController() {
    for (int i = 0; i < lists.length; i++) {
      listNameCardController.add(TextEditingController());
    }
  }

  void initListNameCardAdding() {
    for (int i = 0; i < lists.length; i++) {
      listNameCardAdding.add(false);
    }
  }

  void initListCardScrollController() {
    for (int i = 0; i < lists.length; i++) {
      listCardScrollController.add(ScrollController());
    }
  }
}
