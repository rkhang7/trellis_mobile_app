// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_member_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardMemberRequest _$BoardMemberRequestFromJson(Map<String, dynamic> json) =>
    BoardMemberRequest(
      memberId: json['memberId'] as String,
      permission: json['permission'] as int,
      boardId: json['boardId'] as int,
    );

Map<String, dynamic> _$BoardMemberRequestToJson(BoardMemberRequest instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'permission': instance.permission,
      'boardId': instance.boardId,
    };
