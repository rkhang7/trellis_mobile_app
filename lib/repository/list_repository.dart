import 'package:dio/dio.dart';
import 'package:trellis_mobile_app/api/rest_api.dart';
import 'package:trellis_mobile_app/models/list/list_request.dart';
import 'package:trellis_mobile_app/models/list/list_response.dart';

class ListRepository {
  final dio = Dio(); // Provide a dio instance

  Future<ListResponse> createList(ListRequest listRequest) async {
    final client = RestClient(dio);
    return await client.createList(listRequest);
  }
}
