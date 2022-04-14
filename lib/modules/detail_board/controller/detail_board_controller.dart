import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/models/list/list_request.dart';
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

  void createList() {
    EasyLoading.show(status: "please_wait".tr);
    listRepository
        .createList(ListRequest(
            name: nameListAddingController.text,
            position: lists.length,
            boardId: dashBoardController.boardIdSelected,
            createdBy: dashBoardController.currentId))
        .then((value) {
      EasyLoading.dismiss();

      EasyLoading.showSuccess("create_success".tr);

      nameListAdding.value = false;

      updateController();

      // clean controller
      nameListAddingController.clear();

      // insert to first index list workspace
      lists.add(value);
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

  void updateController() {
    listController.add(TextEditingController());
    listNameListEditing.add(false);
    listNameCardController.add(TextEditingController());
    listNameCardAdding.add(false);
    listCardScrollController.add(ScrollController());
  }

  void updateNameList() {
    EasyLoading.show(status: "please_wait".tr);
    var currentIndex = listNameListEditing.indexOf(true);
    var currentList = lists[currentIndex];
    String newName = listController[currentIndex].text;
    listRepository
        .updateList(
      currentList.list_id,
      ListRequest(
        name: newName,
        position: currentList.position,
        boardId: currentList.board_id,
        createdBy: currentList.created_by,
      ),
    )
        .then((value) {
      EasyLoading.dismiss();

      EasyLoading.showSuccess("update_success".tr);

      //update list
      currentList.name = value.name;
      nameListEditing.value = false;
      listNameListEditing[currentIndex] = false;
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
}
