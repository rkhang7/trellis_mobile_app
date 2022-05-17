import 'package:dio/dio.dart';
import 'package:trellis_mobile_app/models/board/board_request.dart';
import 'package:trellis_mobile_app/models/board/board_response.dart';

import '../api/rest_api.dart';
import '../models/card/card_response.dart';

class BoardRepository {
  final dio = Dio(); // Provide a dio instance

  Future<BoardResponse> createBoard(BoardRequest boardRequest) async {
    final client = RestClient(dio);
    return await client.createBoard(boardRequest);
  }

  Future<List<BoardResponse>> getListBoardsInWorkspace(
      int workspaceId, String uid, String name) async {
    final client = RestClient(dio);
    return await client.getListBoardsInWorkspace(workspaceId, uid, name);
  }

  Future<BoardResponse> getBoardById(int boardId) async {
    final client = RestClient(dio);
    return await client.getBoardById(boardId);
  }

  Future<BoardResponse> updateBoard(
      int boardId, BoardRequest boardRequest) async {
    final client = RestClient(dio);
    return await client.updateBoard(boardId, boardRequest);
  }

  Future<void> deleteBoard(int boardId) async {
    final client = RestClient(dio);
    return await client.deleteBoard(boardId);
  }

  Future<List<BoardResponse>> getBoardByDate(String uid, int date) async {
    final client = RestClient(dio);
    return await client.getBoardByDate(uid, date);
  }

  Future<List<CardResponse>> getCardsInBoard(String uid, int boardId) async {
    final client = RestClient(dio);
    return await client.getCardsInBoard(uid, boardId);
  }
}
