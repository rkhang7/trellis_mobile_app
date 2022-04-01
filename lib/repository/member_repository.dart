import 'package:dio/dio.dart';
import 'package:trellis_mobile_app/models/member/member_request.dart';
import 'package:trellis_mobile_app/models/member/member_response.dart';
import 'package:trellis_mobile_app/models/workspace/workspace_response.dart';

import '../api/rest_api.dart';

class MemberRepository {
  final dio = Dio(); // Provide a dio instance

  Future<MemberResponse> createMemberIntoWorkspace(
      MemberRequest memberRequest) async {
    final client = RestClient(dio);
    return await client.createMemberIntoWorkspace(memberRequest);
  }

  Future<List<MemberResponse>> getListMemberInWorkspace(int workspaceId) async {
    final client = RestClient(dio);
    return await client.getListMemberInWorkspace(workspaceId);
  }
}
