// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardResponse _$BoardResponseFromJson(Map<String, dynamic> json) =>
    BoardResponse(
      board_id: json['board_id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      closed: json['closed'] as bool,
      workspace_id: json['workspace_id'] as int,
      visibility: json['visibility'] as int,
      created_time: json['created_time'] as int,
      updated_time: json['updated_time'] as int,
      created_by: json['created_by'] as String,
    );

Map<String, dynamic> _$BoardResponseToJson(BoardResponse instance) =>
    <String, dynamic>{
      'board_id': instance.board_id,
      'name': instance.name,
      'description': instance.description,
      'closed': instance.closed,
      'visibility': instance.visibility,
      'workspace_id': instance.workspace_id,
      'created_time': instance.created_time,
      'updated_time': instance.updated_time,
      'created_by': instance.created_by,
    };