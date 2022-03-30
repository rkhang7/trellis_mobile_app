// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberRequest _$MemberRequestFromJson(Map<String, dynamic> json) =>
    MemberRequest(
      memberId: json['memberId'] as String,
      permission: json['permission'] as String,
      workspaceId: json['workspaceId'] as String,
    );

Map<String, dynamic> _$MemberRequestToJson(MemberRequest instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'permission': instance.permission,
      'workspaceId': instance.workspaceId,
    };
