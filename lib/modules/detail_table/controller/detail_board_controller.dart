import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/core/card_model.dart';
import 'package:trellis_mobile_app/models/core/list_model.dart';

class DetailBoardController extends GetxController {
  var pageController = PageController(viewportFraction: 0.8);
  var listList = <ListModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  void initData() {
    for (int i = 0; i <= 5; i++) {
      var cardList = <CardModel>[];
      for (int i = 0; i <= 20; i++) {
        cardList.add(
          CardModel(
            id: i.toString(),
            name: "Name Name Name Name $i",
            description: "description $i",
            position: i,
          ),
        );
      }

      listList.add(
          ListModel(id: i.toString(), name: "Cần làm $i", listCard: cardList));
    }
  }
}
