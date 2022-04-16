// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_member_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardMemberResponse _$BoardMemberResponseFromJson(Map<String, dynamic> json) =>
    BoardMemberResponse(
      member_id: json['member_id'] as String,
      permission: json['permission'] as int,
      board_id: json['board_id'] as int,
      created_time: json['created_time'] as int,
      updated_time: json['updated_time'] as int,
    );

Map<String, dynamic> _$BoardMemberResponseToJson(
        BoardMemberResponse instance) =>
    <String, dynamic>{
      'member_id': instance.member_id,
      'permission': instance.permission,
      'board_id': instance.board_id,
      'created_time': instance.created_time,
      'updated_time': instance.updated_time,
    };
