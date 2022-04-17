import 'package:dio/dio.dart';
import 'package:trellis_mobile_app/models/card/card_request.dart';
import 'package:trellis_mobile_app/models/card/card_response.dart';

import '../api/rest_api.dart';

class CardRepository {
  final dio = Dio(); // Provide a dio instance

  Future<CardResponse> creatCard(CardRequest cardRequest) {
    final client = RestClient(dio);
    return client.createCard(cardRequest);
  }
}
