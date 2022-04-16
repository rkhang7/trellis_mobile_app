// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_member_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardMemberDetailResponse _$BoardMemberDetailResponseFromJson(
        Map<String, dynamic> json) =>
    BoardMemberDetailResponse(
      member_id: json['member_id'] as String,
      permission: json['permission'] as int,
      board_id: json['board_id'] as int,
      email: json['email'] as String,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      avatar_background_color: json['avatar_background_color'] as String,
      avatar_url: json['avatar_url'] as String,
      created_time: json['created_time'] as int,
      updated_time: json['updated_time'] as int,
    );

Map<String, dynamic> _$BoardMemberDetailResponseToJson(
        BoardMemberDetailResponse instance) =>
    <String, dynamic>{
      'member_id': instance.member_id,
      'permission': instance.permission,
      'board_id': instance.board_id,
      'email': instance.email,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'avatar_background_color': instance.avatar_background_color,
      'avatar_url': instance.avatar_url,
      'created_time': instance.created_time,
      'updated_time': instance.updated_time,
    };
