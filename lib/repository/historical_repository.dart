import 'package:dio/dio.dart';
import 'package:trellis_mobile_app/models/historical/board_historical_response.dart';

import '../api/rest_api.dart';

class HistoricalRepository {
  final dio = Dio(); // Provide a dio instance

  Future<List<BoardHistoricalResponse>> getBoardHistoricalInBoard(
      int boardId) async {
    final client = RestClient(dio);
    return await client.getBoardHistoricalInBoard(boardId);
  }
}
