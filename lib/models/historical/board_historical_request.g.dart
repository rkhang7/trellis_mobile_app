// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_historical_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardHistoricalRequest _$BoardHistoricalRequestFromJson(
        Map<String, dynamic> json) =>
    BoardHistoricalRequest(
      boardId: json['boardId'] as int,
      uid: json['uid'] as String,
      action: json['action'] as String,
      source: json['source'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$BoardHistoricalRequestToJson(
        BoardHistoricalRequest instance) =>
    <String, dynamic>{
      'boardId': instance.boardId,
      'uid': instance.uid,
      'action': instance.action,
      'source': instance.source,
      'content': instance.content,
    };
