import 'package:dio/dio.dart';
import 'package:trellis_mobile_app/models/member/board_member_request.dart';
import 'package:trellis_mobile_app/models/member/board_member_response.dart';
import 'package:trellis_mobile_app/models/member/card_member_request.dart';
import 'package:trellis_mobile_app/models/member/card_member_response.dart';
import 'package:trellis_mobile_app/models/member/member_detail_response.dart';
import 'package:trellis_mobile_app/models/member/member_request.dart';
import 'package:trellis_mobile_app/models/member/member_response.dart';

import '../api/rest_api.dart';
import '../models/member/board_member_detail_response.dart';

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

  Future<List<BoardMemberResponse>> inviteMultiBoard(
      List<BoardMemberRequest> listBoardMemberRequest) async {
    final client = RestClient(dio);
    return await client.inviteMultiBoard(listBoardMemberRequest);
  }

  Future<void> removeMemberFromWorkspace(String uid, int workspaceId) async {
    final client = RestClient(dio);
    return await client.removeMemberFromWorkspace(uid, workspaceId);
  }

  Future<List<BoardMemberDetailResponse>> getListMemberInBoard(
      int boardId) async {
    final client = RestClient(dio);
    return await client.getListMemberInBoard(boardId);
  }

  Future<void> removeMemberFromBoard(String memberId, int boardId) async {
    final client = RestClient(dio);
    return await client.removeMemberFromBoard(memberId, boardId);
  }

  Future<CardMemberResponse> createMemberIntoCard(
      CardMemberRequest cardMemberRequest) async {
    final client = RestClient(dio);
    return await client.createMemberIntoCard(cardMemberRequest);
  }
}
