// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberResponse _$MemberResponseFromJson(Map<String, dynamic> json) =>
    MemberResponse(
      memberId: json['memberId'] as String,
      permission: json['permission'] as int,
      workspaceId: json['workspaceId'] as int,
      createdTime: json['createdTime'] as int,
      updatedTime: json['updatedTime'] as int,
    );

Map<String, dynamic> _$MemberResponseToJson(MemberResponse instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'permission': instance.permission,
      'workspaceId': instance.workspaceId,
      'createdTime': instance.createdTime,
      'updatedTime': instance.updatedTime,
    };
