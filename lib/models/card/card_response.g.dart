// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardResponse _$CardResponseFromJson(Map<String, dynamic> json) => CardResponse(
      card_id: json['card_id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      position: json['position'] as int,
      start_date: json['start_date'] as int,
      due_date: json['due_date'] as int,
      reminder: json['reminder'] as int,
      list_id: json['list_id'] as int,
      is_complete: json['is_complete'] as bool,
      created_time: json['created_time'] as int,
      updated_time: json['updated_time'] as int,
      created_by: json['created_by'] as String,
      members: (json['members'] as List<dynamic>)
          .map((e) => UserResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      tasks: (json['tasks'] as List<dynamic>)
          .map((e) => TaskResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      labels: (json['labels'] as List<dynamic>)
          .map((e) => LabelResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CardResponseToJson(CardResponse instance) =>
    <String, dynamic>{
      'card_id': instance.card_id,
      'name': instance.name,
      'description': instance.description,
      'position': instance.position,
      'start_date': instance.start_date,
      'due_date': instance.due_date,
      'reminder': instance.reminder,
      'list_id': instance.list_id,
      'is_complete': instance.is_complete,
      'created_time': instance.created_time,
      'updated_time': instance.updated_time,
      'created_by': instance.created_by,
      'members': instance.members,
      'tasks': instance.tasks,
      'labels': instance.labels,
    };
