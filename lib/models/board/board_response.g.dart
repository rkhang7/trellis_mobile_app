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
      background_color: json['background_color'] as String,
      background_dark_color: json['background_dark_color'] as String,
      board_list_resps: (json['board_list_resps'] as List<dynamic>)
          .map((e) => ListResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      'background_color': instance.background_color,
      'background_dark_color': instance.background_dark_color,
      'board_list_resps': instance.board_list_resps,
    };
