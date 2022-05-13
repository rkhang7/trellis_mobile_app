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
          .format(convertTimestampToDate(card.start_date));

      var end = DateFormat('dd/MM, HH:mm')
          .format(convertTimestampToDate(card.due_date));
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
        if (element.is_complete) {
          total++;
        }
      },
    );

    return total;
  }
}
