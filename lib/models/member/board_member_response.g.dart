// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_member_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardMemberResponse _$BoardMemberResponseFromJson(Map<String, dynamic> json) =>
    BoardMemberResponse(
      memberId: json['memberId'] as String,
      permission: json['permission'] as int,
      boardId: json['boardId'] as int,
      createdTime: json['createdTime'] as int,
      updatedTime: json['updatedTime'] as int,
    );

Map<String, dynamic> _$BoardMemberResponseToJson(
        BoardMemberResponse instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'permission': instance.permission,
      'boardId': instance.boardId,
      'createdTime': instance.createdTime,
      'updatedTime': instance.updatedTime,
    };
