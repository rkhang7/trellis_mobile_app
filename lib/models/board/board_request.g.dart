// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardRequest _$BoardRequestFromJson(Map<String, dynamic> json) => BoardRequest(
      name: json['name'] as String,
      description: json['description'] as String,
      closed: json['closed'] as bool,
      visibility: json['visibility'] as int,
      workspaceId: json['workspaceId'] as int,
      createdBy: json['createdBy'] as String,
      backgroundColor: json['backgroundColor'] as String,
      backgroundDarkColor: json['backgroundDarkColor'] as String,
    );

Map<String, dynamic> _$BoardRequestToJson(BoardRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'closed': instance.closed,
      'visibility': instance.visibility,
      'workspaceId': instance.workspaceId,
      'createdBy': instance.createdBy,
      'backgroundColor': instance.backgroundColor,
      'backgroundDarkColor': instance.backgroundDarkColor,
    };
