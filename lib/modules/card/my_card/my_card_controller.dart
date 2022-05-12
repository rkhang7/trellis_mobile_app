import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/models/board/board_response.dart';
import 'package:trellis_mobile_app/modules/dashboard/dashboard_controller.dart';
import 'package:trellis_mobile_app/repository/board_repository.dart';

class MyCardController extends GetxController {
  final boardRepository = Get.find<BoardRepository>();
  final dashBoardController = Get.find<DashBoardController>();

  var listBoard = <BoardResponse>[].obs;
  var dateSelected = DateTime.now().obs;
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
}
