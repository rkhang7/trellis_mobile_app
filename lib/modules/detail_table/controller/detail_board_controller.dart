import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/core/card_model.dart';
import 'package:trellis_mobile_app/models/core/list_model.dart';

class DetailBoardController extends GetxController {
  var pageController = PageController(viewportFraction: 0.8);
  var listCardScrollController = <ScrollController>[];

  var listList = <ListModel>[].obs;
  var nameListEditing = false.obs; // appbar
  var listNameListEditing = <bool>[].obs; // item
  var listController = <TextEditingController>[];
  var nameListIsEmpty = false.obs;

  //card
  var listNameCardAdding = <bool>[].obs;
  var listNameCardController = <TextEditingController>[];

  @override
  void onInit() {
    super.onInit();
    initData();
    initListController();
    initListEditing();
    initListNameCardController();
    initListNameCardAdding();
    initListCardScrollController();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    pageController.dispose();
  }

  void initData() {
    for (int i = 0; i <= 5; i++) {
      var cardList = <CardModel>[];
      for (int i = 0; i <= 50; i++) {
        cardList.add(
          CardModel(
            id: i.toString(),
            name:
                "Name Name Name Name Name Name Name Name Name Name Name Name $i",
            description: "description $i",
            position: i,
          ),
        );
      }

      listList.add(
          ListModel(id: i.toString(), name: "Cần làm $i", listCard: cardList));
    }
  }

  void initListController() {
    for (int i = 0; i < listList.length; i++) {
      listController.add(TextEditingController());
    }
  }

  void initListEditing() {
    for (int i = 0; i < listList.length; i++) {
      listNameListEditing.add(false);
    }
  }

  void initListNameCardController() {
    for (int i = 0; i < listList.length; i++) {
      listNameCardController.add(TextEditingController());
    }
  }

  void initListNameCardAdding() {
    for (int i = 0; i < listList.length; i++) {
      listNameCardAdding.add(false);
    }
  }

  void initListCardScrollController() {
    for (int i = 0; i < listList.length; i++) {
      listCardScrollController.add(ScrollController());
    }
  }
}
