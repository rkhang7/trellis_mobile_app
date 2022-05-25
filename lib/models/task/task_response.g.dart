// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskResponse _$TaskResponseFromJson(Map<String, dynamic> json) => TaskResponse(
      taskId: json['taskId'] as int,
      name: json['name'] as String,
      position: json['position'] as int,
      cardId: json['cardId'] as int,
      isComplete: json['isComplete'] as bool,
      createdTime: json['createdTime'] as int,
      updatedTime: json['updatedTime'] as int,
      createdBy: json['createdBy'] as String,
    );

Map<String, dynamic> _$TaskResponseToJson(TaskResponse instance) =>
    <String, dynamic>{
      'taskId': instance.taskId,
      'name': instance.name,
      'position': instance.position,
      'cardId': instance.cardId,
      'isComplete': instance.isComplete,
      'createdTime': instance.createdTime,
      'updatedTime': instance.updatedTime,
      'createdBy': instance.createdBy,
    };
