// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkSpaceRequest _$WorkSpaceRequestFromJson(Map<String, dynamic> json) =>
    WorkSpaceRequest(
      name: json['name'] as String,
      workspaceType: json['workspaceType'] as String,
      description: json['description'] as String?,
      closed: json['closed'] as bool,
      createdBy: json['createdBy'] as String,
    );

Map<String, dynamic> _$WorkSpaceRequestToJson(WorkSpaceRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'workspaceType': instance.workspaceType,
      'description': instance.description,
      'closed': instance.closed,
      'createdBy': instance.createdBy,
    };
