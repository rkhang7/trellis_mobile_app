// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskRequest _$TaskRequestFromJson(Map<String, dynamic> json) => TaskRequest(
      name: json['name'] as String,
      position: json['position'] as int,
      cardId: json['cardId'] as int,
      isComplete: json['isComplete'] as bool,
      createdBy: json['createdBy'] as String,
    );

Map<String, dynamic> _$TaskRequestToJson(TaskRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'position': instance.position,
      'cardId': instance.cardId,
      'isComplete': instance.isComplete,
      'createdBy': instance.createdBy,
    };
