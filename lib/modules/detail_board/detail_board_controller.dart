import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trellis_mobile_app/models/card/card_response.dart';
import 'package:trellis_mobile_app/models/list/list_request.dart';
import 'package:trellis_mobile_app/models/list/list_response.dart';
import 'package:trellis_mobile_app/modules/dashboard/dashboard_controller.dart';
import 'package:trellis_mobile_app/repository/card_repository.dart';
import 'package:trellis_mobile_app/repository/list_repository.dart';

class DetailBoardController extends GetxController {
  final listRepository = Get.find<ListRepository>();
  final cardRepository = Get.find<CardRepository>();
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

  var nameList = ''.obs;

  final name = Get.parameters['name'].obs;

  var backgroundColor = "".obs;
  var appBarColor = "".obs;

  final selectedCard = CardResponse(
    card_id: -1,
    name: "name",
    description: "description",
    position: -1,
    start_date: 1,
    due_date: 1,
    reminder: 1,
    list_id: -1,
    is_complete: false,
    created_time: 1,
    updated_time: 1,
    created_by: "",
    members: [],
    tasks: [],
    labels: [],
  ).obs;

  @override
  void onInit() {
    initData();
    backgroundColor.value =
        dashBoardController.getBoardSelected()!.background_color;
    appBarColor.value =
        dashBoardController.getBoardSelected()!.background_dark_color;
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
        .then(
      (value) {
        lists.assignAll(value);

        initListController();
        initListEditing();
        initListNameCardController();
        initListNameCardAdding();
        initListCardScrollController();
      },
    );
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

  ListResponse findListById(int id) {
    return lists.firstWhere((element) => element.list_id == id);
  }

  int findIndexListById(int id) {
    return lists.indexWhere((element) => element.list_id == id);
  }

  DateTime convertTimestampToDate(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return date;
  }

  String getDateShowUI(CardResponse card) {
    String s = "";

    if (Get.locale.toString() == "vi_VN") {
      var start = DateFormat('dd/MM, HH:mm')
          .format(convertTimestampToDate(card.start_date));

      var end = DateFormat('dd/MM, HH:mm')
          .format(convertTimestampToDate(card.due_date));
      s = "$start  -  $end";
    }

    return s;
  }

  void moveCards(int listId, int oldIndex, int newIndex) {
    EasyLoading.show(status: "please_wait".tr);
    cardRepository.moveCards(listId, oldIndex, newIndex).then((value) {
      EasyLoading.dismiss();
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

  int getLengthTaskIsComplete(CardResponse cardResponse) {
    int total = 0;
    cardResponse.tasks.forEach(
      (element) {
        if (element.is_complete) {
          total++;
        }
      },
    );

    return total;
  }

  void deleteList(int listId, int index) {
    EasyLoading.show(status: "please_wait".tr);
    listRepository.deleteList(listId).then((value) {
      lists.removeAt(index);
      lists.refresh();
      EasyLoading.dismiss();
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
