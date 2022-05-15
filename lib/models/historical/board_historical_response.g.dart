// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_historical_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardHistoricalResponse _$BoardHistoricalResponseFromJson(
        Map<String, dynamic> json) =>
    BoardHistoricalResponse(
      board_id: json['board_id'] as int,
      uid: json['uid'] as String,
      email: json['email'] as String,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      avatar_background_color: json['avatar_background_color'] as String,
      avatar_url: json['avatar_url'] as String,
      content: json['content'] as String,
      created_time: json['created_time'] as int,
      updated_time: json['updated_time'] as int,
    );

Map<String, dynamic> _$BoardHistoricalResponseToJson(
        BoardHistoricalResponse instance) =>
    <String, dynamic>{
      'board_id': instance.board_id,
      'uid': instance.uid,
      'email': instance.email,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'avatar_background_color': instance.avatar_background_color,
      'avatar_url': instance.avatar_url,
      'content': instance.content,
      'created_time': instance.created_time,
      'updated_time': instance.updated_time,
    };
