import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trellis_mobile_app/models/card/card_response.dart';
import 'package:trellis_mobile_app/modules/dashboard/dashboard_controller.dart';
import 'package:trellis_mobile_app/modules/detail_board/detail_board_controller.dart';
import 'package:trellis_mobile_app/repository/board_repository.dart';

class MyCalendarController extends GetxController {
  var listCard = <CardResponse>[].obs;
  final dashBoarController = Get.find<DashBoardController>();
  final boardRepository = Get.find<BoardRepository>();
  final detailBoardController = Get.find<DetailBoardController>();

  @override
  void onInit() async {
    await boardRepository
        .getCardsInBoard(
            dashBoarController.currentId, dashBoarController.boardIdSelected)
        .then(
      (value) {
        listCard.assignAll(value);
      },
    );
    super.onInit();
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

  String getDateShowUI(CardResponse card) {
    String s = "";

    var start = DateFormat('dd-MM-yyyy, kk:mm')
        .format(convertTimestampToDate(card.startDate));

    var end = DateFormat('dd-MM-yyyy, kk:mm')
        .format(convertTimestampToDate(card.dueDate));
    s = "$start\n$end";

    return s;
  }

  DateTime convertTimestampToDate(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return date;
  }
}
