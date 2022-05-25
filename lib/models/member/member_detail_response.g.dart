// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberDetailResponse _$MemberDetailResponseFromJson(
        Map<String, dynamic> json) =>
    MemberDetailResponse(
      memberId: json['memberId'] as String,
      permission: json['permission'] as int,
      workspaceId: json['workspaceId'] as int,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      avatarBackgroundColor: json['avatarBackgroundColor'] as String,
      avatarUrl: json['avatarUrl'] as String,
      createdTime: json['createdTime'] as int,
      updatedTime: json['updatedTime'] as int,
    );

Map<String, dynamic> _$MemberDetailResponseToJson(
        MemberDetailResponse instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'permission': instance.permission,
      'workspaceId': instance.workspaceId,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avatarBackgroundColor': instance.avatarBackgroundColor,
      'avatarUrl': instance.avatarUrl,
      'createdTime': instance.createdTime,
      'updatedTime': instance.updatedTime,
    };
