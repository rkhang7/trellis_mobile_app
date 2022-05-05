// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskResponse _$TaskResponseFromJson(Map<String, dynamic> json) => TaskResponse(
      task_id: json['task_id'] as int,
      name: json['name'] as String,
      position: json['position'] as int,
      card_id: json['card_id'] as int,
      is_complete: json['is_complete'] as bool,
      created_time: json['created_time'] as int,
      updated_time: json['updated_time'] as int,
      created_by: json['created_by'] as int,
    );

Map<String, dynamic> _$TaskResponseToJson(TaskResponse instance) =>
    <String, dynamic>{
      'task_id': instance.task_id,
      'name': instance.name,
      'position': instance.position,
      'card_id': instance.card_id,
      'is_complete': instance.is_complete,
      'created_time': instance.created_time,
      'updated_time': instance.updated_time,
      'created_by': instance.created_by,
    };
