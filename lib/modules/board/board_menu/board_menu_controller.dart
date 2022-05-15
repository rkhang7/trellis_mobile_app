import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trellis_mobile_app/models/board/board_response.dart';
import 'package:trellis_mobile_app/models/historical/board_historical_response.dart';
import 'package:trellis_mobile_app/models/label/label_request.dart';
import 'package:trellis_mobile_app/models/label/label_response.dart';
import 'package:trellis_mobile_app/models/member/board_member_detail_response.dart';
import 'package:trellis_mobile_app/models/my_color.dart';
import 'package:trellis_mobile_app/modules/dashboard/dashboard_controller.dart';
import 'package:trellis_mobile_app/repository/board_repository.dart';
import 'package:trellis_mobile_app/repository/historical_repository.dart';
import 'package:trellis_mobile_app/repository/label_reposittory.dart';
import 'package:trellis_mobile_app/repository/member_repository.dart';
import 'package:trellis_mobile_app/utils/common.dart';

class BoardMenuController extends GetxController {
  var listMember = <BoardMemberDetailResponse>[].obs;
  final dashBoardController = Get.find<DashBoardController>();
  final memberRepository = Get.find<MemberRepository>();
  final historicalRepository = Get.find<HistoricalRepository>();
  final boardRepository = Get.find<BoardRepository>();
  final labelRepository = Get.find<LabelRepository>();
  final labelNameController = TextEditingController();
  BoardResponse? currentBoard;
  var listLabelColor = <MyColor>[].obs;

  var listLabel = <LabelResponse>[].obs;

  var editingLabel = false.obs;

  final listBoardHistorical = <BoardHistoricalResponse>[];

  @override
  void onInit() {
    listLabelColor.value = Common.getListLabelColor();

    loadBoard();
    initListMember();
    initBoardHistorical();
    super.onInit();
  }

  void initListMember() {
    memberRepository
        .getListMemberInBoard(dashBoardController.boardIdSelected)
        .then((value) {
      listMember.assignAll(value);
    });
  }

  void loadBoard() {
    boardRepository
        .getBoardById(dashBoardController.boardIdSelected)
        .then((value) {
      currentBoard = value;
    });
  }

  bool currentUserIsAdmin() {
    if (listMember.isNotEmpty) {
      for (BoardMemberDetailResponse boardMemberDetailResponse in listMember) {
        if (boardMemberDetailResponse.member_id ==
            dashBoardController.currentId) {
          return true;
        }
      }
      return false;
    } else {
      return false;
    }
  }

  void changeBackgroundBoard(int index) {
    for (MyColor myColor in listLabelColor) {
      myColor.isSelect = false;
    }
    listLabelColor[index].isSelect = true;
    listLabelColor.refresh();
  }

  void createLabel() {
    EasyLoading.show(status: "please_wait".tr);
    final labelRequest = LabelRequest(
        name: labelNameController.text,
        color: listLabelColor[
                listLabelColor.indexWhere((element) => element.isSelect)]
            .color,
        boardId: currentBoard!.board_id);

    labelRepository.createLabel(labelRequest).then(
      (value) {
        labelNameController.clear();
        listLabel.add(value);
        EasyLoading.dismiss();
        EasyLoading.showSuccess("create_success".tr);
        Get.back();
      },
    ).catchError((Object obj) {
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

  void updateLabel(int labelId) {
    EasyLoading.show(status: "please_wait".tr);
    final labelRequest = LabelRequest(
        name: labelNameController.text,
        color: listLabelColor[
                listLabelColor.indexWhere((element) => element.isSelect)]
            .color,
        boardId: currentBoard!.board_id);

    labelRepository.updateLabel(labelId, labelRequest).then(
      (value) {
        labelNameController.clear();
        listLabel[
                listLabel.indexWhere((element) => element.label_id == labelId)]
            .color = value.color;
        listLabel[
                listLabel.indexWhere((element) => element.label_id == labelId)]
            .name = value.name;
        listLabel.refresh();
        EasyLoading.dismiss();
        EasyLoading.showSuccess("update_success".tr);
        Get.back();
      },
    ).catchError((Object obj) {
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

  void getListLabel() {
    labelRepository.getLabelsInBoard(currentBoard!.board_id).then((value) {
      listLabel.assignAll(value);
    });
  }

  void updateLabelColorSelected(String color) {
    for (MyColor myColor in listLabelColor) {
      if (myColor.color == color) {
        myColor.isSelect = true;
      } else {
        myColor.isSelect = false;
      }
    }
  }

  void initBoardHistorical() async {
    await historicalRepository
        .getBoardHistoricalInBoard(dashBoardController.boardIdSelected)
        .then(
      (value) {
        listBoardHistorical.assignAll(value);
      },
    );
  }

  String handleDateTimeShowUI(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String formattedDate = DateFormat('dd-MM-yyyy').format(date);
    String formattedTime = DateFormat('HH:mm').format(date);
    return "$formattedDate ${'at'.tr} $formattedTime";
  }
}
