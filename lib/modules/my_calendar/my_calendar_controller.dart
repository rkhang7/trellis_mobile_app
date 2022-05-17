import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/card/card_response.dart';
import 'package:trellis_mobile_app/modules/dashboard/dashboard_controller.dart';
import 'package:trellis_mobile_app/repository/board_repository.dart';

class MyCalendarController extends GetxController {
  var listCard = <CardResponse>[].obs;
  final dashBoarController = Get.find<DashBoardController>();
  final boardRepository = Get.find<BoardRepository>();

  @override
  void onInit() async {
    // TODO: implement onInit
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
}
