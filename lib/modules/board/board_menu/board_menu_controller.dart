import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/board/board_response.dart';
import 'package:trellis_mobile_app/models/member/board_member_detail_response.dart';
import 'package:trellis_mobile_app/models/my_color.dart';
import 'package:trellis_mobile_app/modules/dashboard/dashboard_controller.dart';
import 'package:trellis_mobile_app/repository/board_repository.dart';
import 'package:trellis_mobile_app/repository/member_repository.dart';
import 'package:trellis_mobile_app/utils/common.dart';

class BoardMenuController extends GetxController {
  var listMember = <BoardMemberDetailResponse>[].obs;
  final dashBoardController = Get.find<DashBoardController>();
  final memberRepository = Get.find<MemberRepository>();
  final boardRepository = Get.find<BoardRepository>();
  BoardResponse? currentBoard;
  List<MyColor> listLabelColor = <MyColor>[].obs;

  @override
  void onInit() {
    listLabelColor = Common.getListLabelColor();
    loadBoard();
    initListMember();

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
    listLabelColor.forEach((element) {
      element.isSelect = false;
    });
    listLabelColor[index].isSelect = true;
  }
}
