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

  Future<List<WorkSpaceResponse>> getWorkspacesByUid(String uid) async {
    final client = RestClient(dio);
    return await client.getWorkspacesByUid(uid);
  }

  Future<WorkSpaceResponse> updateWorkspace(
      int workspaceId, WorkSpaceRequest workSpaceRequest) async {
    final client = RestClient(dio);
    return await client.updateWorkspace(workspaceId, workSpaceRequest);
  }

  Future<void> deleteWorkspace(int workspaceId) async {
    final client = RestClient(dio);
    return await client.deleteWorkspace(workspaceId);
  }
}
