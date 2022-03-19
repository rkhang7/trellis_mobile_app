import 'package:dio/dio.dart';
import 'package:trellis_mobile_app/models/workspace/workspace_request.dart';
import 'package:trellis_mobile_app/models/workspace/workspace_response.dart';

import '../api/rest_api.dart';

class WorkspaceRepository {
  final dio = Dio(); // Provide a dio instance

  Future<WorkSpaceResponse> createWorkspace(
      WorkSpaceRequest workSpaceRequest) async {
    final client = RestClient(dio);
    return await client.createWorkspace(workSpaceRequest);
  }
}
