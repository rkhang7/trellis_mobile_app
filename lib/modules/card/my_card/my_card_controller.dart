import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/models/board/board_response.dart';
import 'package:trellis_mobile_app/modules/dashboard/dashboard_controller.dart';
import 'package:trellis_mobile_app/repository/board_repository.dart';

import '../../../models/card/card_response.dart';

class MyCardController extends GetxController {
  final boardRepository = Get.find<BoardRepository>();
  final dashBoardController = Get.find<DashBoardController>();

  var listBoard = <BoardResponse>[].obs;
  var dateSelected = DateTime.now().obs;

  final selectedCard = CardResponse(
    cardId: -1,
    name: "name",
    description: "description",
    position: -1,
    startDate: 1,
    dueDate: 1,
    reminder: 1,
    listName: "",
    listId: -1,
    isComplete: false,
    createdTime: 1,
    updatedTime: 1,
    createdBy: "",
    members: [],
    tasks: [],
    labels: [],
  ).obs;
  @override
  void onInit() {
    getBoardsByDate(
      dateSelected.value.toUtc().millisecondsSinceEpoch,
    );
    super.onInit();
  }

  void getBoardsByDate(int date) {
    EasyLoading.show(status: "please_wait".tr);
    boardRepository
        .getBoardByDate(dashBoardController.currentId, date)
        .then((value) {
      log(date.toString());
      EasyLoading.dismiss();
      listBoard.assignAll(value);
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

  String getDateShowUI(CardResponse card) {
    String s = "";

    if (Get.locale.toString() == "vi_VN") {
      var start = DateFormat('dd/MM, HH:mm')
          .format(convertTimestampToDate(card.startDate));

      var end = DateFormat('dd/MM, HH:mm')
          .format(convertTimestampToDate(card.dueDate));
      s = "$start  -  $end";
    }

    return s;
  }

  DateTime convertTimestampToDate(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return date;
  }

  int getLengthTaskIsComplete(CardResponse cardResponse) {
    int total = 0;
    cardResponse.tasks.forEach(
      (element) {
        if (element.isComplete) {
          total++;
        }
      },
    );

    return total;
  }
}
