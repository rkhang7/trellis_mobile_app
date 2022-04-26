import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/board/board_request.dart';
import 'package:trellis_mobile_app/modules/board/board_menu/board_menu_controller.dart';
import 'package:trellis_mobile_app/modules/dashboard/dashboard_controller.dart';
import 'package:trellis_mobile_app/modules/detail_board/detail_board_controller.dart';
import 'package:trellis_mobile_app/repository/board_repository.dart';

class UpdateBoardController extends GetxController {
  var boardNameController = TextEditingController();
  var descriptionController = TextEditingController();

  var boardNameIsEmpty = false.obs;
  var selectedType = 1.obs;

  final boardMenuController = Get.find<BoardMenuController>();
  final boardRepository = Get.find<BoardRepository>();
  final dashBoardController = Get.find<DashBoardController>();
  final detailBoardController = Get.find<DetailBoardController>();
  @override
  void onInit() {
    initData();
    super.onInit();
  }

  void initData() {
    boardNameController.text = boardMenuController.currentBoard!.name;
    descriptionController.text = boardMenuController.currentBoard!.description;
    selectedType.value = boardMenuController.currentBoard!.visibility;
  }

  void updateBoard() {
    EasyLoading.show(status: "please_wait".tr);
    int boardId = boardMenuController.currentBoard!.board_id;
    boardRepository
        .updateBoard(
            boardId,
            BoardRequest(
              name: boardNameController.text.trim(),
              description: descriptionController.text,
              closed: false,
              workspaceId: boardMenuController.currentBoard!.workspace_id,
              visibility: selectedType.value,
              createdBy: boardMenuController.currentBoard!.created_by,
              backgroundColor:
                  boardMenuController.currentBoard!.background_color,
              backgroundDarkColor:
                  boardMenuController.currentBoard!.background_dark_color,
            ))
        .then((value) {
      int index = dashBoardController.findIndexBoardById(boardId);
      dashBoardController.listBoards[index].name = value.name;
      dashBoardController.listBoards[index].description = value.description;
      dashBoardController.listBoards[index].visibility = value.visibility;

      dashBoardController.listBoards.refresh();
      detailBoardController.name.value = value.name;

      EasyLoading.dismiss();

      EasyLoading.showSuccess("update_success".tr);
      Get.back();
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
  }
}
