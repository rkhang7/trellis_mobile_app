// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardResponse _$BoardResponseFromJson(Map<String, dynamic> json) =>
    BoardResponse(
      boardId: json['boardId'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      closed: json['closed'] as bool,
      workspaceId: json['workspaceId'] as int,
      visibility: json['visibility'] as int,
      createdTime: json['createdTime'] as int,
      updatedTime: json['updatedTime'] as int,
      createdBy: json['createdBy'] as String,
      backgroundColor: json['backgroundColor'] as String,
      backgroundDarkColor: json['backgroundDarkColor'] as String,
      boardListResps: (json['boardListResps'] as List<dynamic>)
          .map((e) => ListResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BoardResponseToJson(BoardResponse instance) =>
    <String, dynamic>{
      'boardId': instance.boardId,
      'name': instance.name,
      'description': instance.description,
      'closed': instance.closed,
      'visibility': instance.visibility,
      'workspaceId': instance.workspaceId,
      'createdTime': instance.createdTime,
      'updatedTime': instance.updatedTime,
      'createdBy': instance.createdBy,
      'backgroundColor': instance.backgroundColor,
      'backgroundDarkColor': instance.backgroundDarkColor,
      'boardListResps': instance.boardListResps,
    };
