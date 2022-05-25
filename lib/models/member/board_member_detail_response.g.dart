// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_member_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardMemberDetailResponse _$BoardMemberDetailResponseFromJson(
        Map<String, dynamic> json) =>
    BoardMemberDetailResponse(
      memberId: json['memberId'] as String,
      permission: json['permission'] as int,
      boardId: json['boardId'] as int,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      avatarBackgroundColor: json['avatarBackgroundColor'] as String,
      avatarUrl: json['avatarUrl'] as String,
      createdTime: json['createdTime'] as int,
      updatedTime: json['updatedTime'] as int,
    );

Map<String, dynamic> _$BoardMemberDetailResponseToJson(
        BoardMemberDetailResponse instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'permission': instance.permission,
      'boardId': instance.boardId,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avatarBackgroundColor': instance.avatarBackgroundColor,
      'avatarUrl': instance.avatarUrl,
      'createdTime': instance.createdTime,
      'updatedTime': instance.updatedTime,
    };
