// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkSpaceResponse _$WorkSpaceResponseFromJson(Map<String, dynamic> json) =>
    WorkSpaceResponse(
      workspace_id: json['workspace_id'] as int,
      name: json['name'] as String,
      workspace_type: json['workspace_type'] as String,
      description: json['description'] as String,
      closed: json['closed'] as bool,
      created_time: json['created_time'] as int,
      updated_time: json['updated_time'] as int,
      created_by: json['created_by'] as String,
    );

Map<String, dynamic> _$WorkSpaceResponseToJson(WorkSpaceResponse instance) =>
    <String, dynamic>{
      'workspace_id': instance.workspace_id,
      'name': instance.name,
      'workspace_type': instance.workspace_type,
      'description': instance.description,
      'closed': instance.closed,
      'created_time': instance.created_time,
      'updated_time': instance.updated_time,
      'created_by': instance.created_by,
    };
