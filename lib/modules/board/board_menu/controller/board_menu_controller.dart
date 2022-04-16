import 'package:get/get.dart';
import 'package:trellis_mobile_app/models/board/board_response.dart';
import 'package:trellis_mobile_app/models/member/board_member_detail_response.dart';
import 'package:trellis_mobile_app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:trellis_mobile_app/repository/board_repository.dart';
import 'package:trellis_mobile_app/repository/member_repository.dart';

class BoardMenuController extends GetxController {
  var listMember = <BoardMemberDetailResponse>[].obs;
  final dashBoardController = Get.find<DashBoardController>();
  final memberRepository = Get.find<MemberRepository>();
  final boardRepository = Get.find<BoardRepository>();
  BoardResponse? currentBoard;

  @override
  void onInit() {
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
}
