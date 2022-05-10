import 'package:dio/dio.dart';
import 'package:trellis_mobile_app/models/label/label_request.dart';
import 'package:trellis_mobile_app/models/label/label_response.dart';

import '../api/rest_api.dart';

class LabelRepository {
  final dio = Dio(); // Provide a dio instance

  Future<LabelResponse> createLabel(LabelRequest labelRequest) async {
    final client = RestClient(dio);
    return await client.createLabel(labelRequest);
  }
}
