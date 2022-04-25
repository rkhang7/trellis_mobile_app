import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/board/board_request.dart';
import 'package:trellis_mobile_app/models/my_color.dart';
import 'package:trellis_mobile_app/modules/dashboard/dashboard_controller.dart';
import 'package:trellis_mobile_app/modules/detail_board/detail_board_controller.dart';
import 'package:trellis_mobile_app/repository/board_repository.dart';
import 'package:trellis_mobile_app/utils/common.dart';

class BoardBackgroundController extends GetxController {
  var listMyColor = <MyColor>[].obs;
  var dashBoardController = Get.find<DashBoardController>();
  var detailBoardController = Get.find<DetailBoardController>();
  final boardRepository = Get.find<BoardRepository>();

  @override
  void onInit() {
    listMyColor.value = Common.getListBackgroundBoard();
    super.onInit();
  }

  void unSelectListColor() {
    listMyColor.forEach((element) {
      element.isSelect = false;
    });
  }

  void changeBackgroundBoard(int colorIndex, String newColor) {
    EasyLoading.show(status: "please_wait".tr);
    unSelectListColor();
    listMyColor[colorIndex].isSelect = true;
    listMyColor.refresh();
    int indexBoard = dashBoardController
        .findIndexBoardById(dashBoardController.boardIdSelected);
    dashBoardController.listBoards[indexBoard].background_color = newColor;
    dashBoardController.listBoards.refresh();
    detailBoardController.backgroundColor.value = newColor;

    boardRepository
        .updateBoard(
      dashBoardController.boardIdSelected,
      BoardRequest(
          name: dashBoardController.listBoards[indexBoard].name,
          description: dashBoardController.listBoards[indexBoard].description,
          closed: dashBoardController.listBoards[indexBoard].closed,
          visibility: dashBoardController.listBoards[indexBoard].visibility,
          workspaceId: dashBoardController.listBoards[indexBoard].workspace_id,
          createdBy: dashBoardController.listBoards[indexBoard].created_by,
          backgroundColor: newColor),
    )
        .then((value) {
      EasyLoading.dismiss();
      Get.back();
      Get.back();
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
    ;
  }
}
