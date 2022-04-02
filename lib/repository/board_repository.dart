import 'package:dio/dio.dart';
import 'package:trellis_mobile_app/models/board/board_request.dart';
import 'package:trellis_mobile_app/models/board/board_response.dart';

import '../api/rest_api.dart';

class BoardRepository {
  final dio = Dio(); // Provide a dio instance

  Future<BoardResponse> createBoard(BoardRequest boardRequest) async {
    final client = RestClient(dio);
    return await client.createBoard(boardRequest);
  }

  Future<List<BoardResponse>> getListBoardsInWorkspace(
      int workspaceId, String uid) async {
    final client = RestClient(dio);
    return await client.getListBoardsInWorkspace(workspaceId, uid);
  }
}
