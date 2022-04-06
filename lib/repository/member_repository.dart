import 'package:dio/dio.dart';
import 'package:trellis_mobile_app/models/member/member_detail_response.dart';
import 'package:trellis_mobile_app/models/member/member_request.dart';
import 'package:trellis_mobile_app/models/member/member_response.dart';

import '../api/rest_api.dart';

class MemberRepository {
  final dio = Dio(); // Provide a dio instance

  Future<MemberResponse> createMemberIntoWorkspace(
      MemberRequest memberRequest) async {
    final client = RestClient(dio);
    return await client.createMemberIntoWorkspace(memberRequest);
  }

  Future<List<MemberDetailResponse>> getListMemberInWorkspace(
      int workspaceId) async {
    final client = RestClient(dio);
    return await client.getListMemberInWorkspace(workspaceId);
  }

  Future<List<MemberResponse>> inviteMulti(
      List<MemberRequest> listMemberRequest) async {
    final client = RestClient(dio);
    return await client.inviteMulti(listMemberRequest);
  }

  Future<void> removeMemberFromWorkspace(String uid, int workspaceId) async {
    final client = RestClient(dio);
    return await client.removeMemberFromWorkspace(uid, workspaceId);
  }
}
