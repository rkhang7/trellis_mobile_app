// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_historical_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardHistoricalResponse _$BoardHistoricalResponseFromJson(
        Map<String, dynamic> json) =>
    BoardHistoricalResponse(
      boardId: json['boardId'] as int,
      uid: json['uid'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      avatarBackgroundColor: json['avatarBackgroundColor'] as String,
      avatarURL: json['avatarURL'] as String,
      content: json['content'] as String,
      createdTime: json['createdTime'] as int,
      updatedTime: json['updatedTime'] as int,
    );

Map<String, dynamic> _$BoardHistoricalResponseToJson(
        BoardHistoricalResponse instance) =>
    <String, dynamic>{
      'boardId': instance.boardId,
      'uid': instance.uid,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avatarBackgroundColor': instance.avatarBackgroundColor,
      'avatarURL': instance.avatarURL,
      'content': instance.content,
      'createdTime': instance.createdTime,
      'updatedTime': instance.updatedTime,
    };
