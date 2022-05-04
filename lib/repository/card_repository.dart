import 'package:dio/dio.dart';
import 'package:trellis_mobile_app/models/card/card_request.dart';
import 'package:trellis_mobile_app/models/card/card_response.dart';

import '../api/rest_api.dart';

class CardRepository {
  final dio = Dio(); // Provide a dio instance

  Future<CardResponse> createCard(CardRequest cardRequest) {
    final client = RestClient(dio);
    return client.createCard(cardRequest);
  }

  Future<String> moveCards(int listId, int oldIndex, int newIndex) async {
    final client = RestClient(dio);
    return await client.moveCards(listId, oldIndex, newIndex);
  }

  Future<CardResponse> updateCard(int cardId, CardRequest cardRequest) async {
    final client = RestClient(dio);
    return await client.updateCard(cardId, cardRequest);
  }
}
