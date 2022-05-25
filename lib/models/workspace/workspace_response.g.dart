// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkSpaceResponse _$WorkSpaceResponseFromJson(Map<String, dynamic> json) =>
    WorkSpaceResponse(
      workspaceId: json['workspaceId'] as int,
      name: json['name'] as String,
      workspaceType: json['workspaceType'] as String,
      description: json['description'] as String,
      closed: json['closed'] as bool,
      createdTime: json['createdTime'] as int,
      updatedTime: json['updatedTime'] as int,
      createdBy: json['createdBy'] as String,
    );

Map<String, dynamic> _$WorkSpaceResponseToJson(WorkSpaceResponse instance) =>
    <String, dynamic>{
      'workspaceId': instance.workspaceId,
      'name': instance.name,
      'workspaceType': instance.workspaceType,
      'description': instance.description,
      'closed': instance.closed,
      'createdTime': instance.createdTime,
      'updatedTime': instance.updatedTime,
      'createdBy': instance.createdBy,
    };
