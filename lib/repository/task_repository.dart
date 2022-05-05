import 'package:dio/dio.dart';
import 'package:trellis_mobile_app/models/task/task_request.dart';
import 'package:trellis_mobile_app/models/task/task_response.dart';

import '../api/rest_api.dart';

class TaskRepository {
  final dio = Dio(); // Provide a dio instance

  Future<TaskResponse> createTask(TaskRequest taskRequest) async {
    final client = RestClient(dio);
    return await client.createTask(taskRequest);
  }
}
