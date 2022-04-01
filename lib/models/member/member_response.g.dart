// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberResponse _$MemberResponseFromJson(Map<String, dynamic> json) =>
    MemberResponse(
      member_id: json['member_id'] as String,
      permission: json['permission'] as int,
      workspace_id: json['workspace_id'] as int,
      created_time: json['created_time'] as int,
      updated_time: json['updated_time'] as int,
    );

Map<String, dynamic> _$MemberResponseToJson(MemberResponse instance) =>
    <String, dynamic>{
      'member_id': instance.member_id,
      'permission': instance.permission,
      'workspace_id': instance.workspace_id,
      'created_time': instance.created_time,
      'updated_time': instance.updated_time,
    };
