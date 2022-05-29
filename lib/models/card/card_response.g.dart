// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardResponse _$CardResponseFromJson(Map<String, dynamic> json) => CardResponse(
      cardId: json['cardId'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      position: json['position'] as int,
      startDate: json['startDate'] as int,
      dueDate: json['dueDate'] as int,
      reminder: json['reminder'] as int,
      listId: json['listId'] as int,
      isComplete: json['isComplete'] as bool,
      createdTime: json['createdTime'] as int,
      updatedTime: json['updatedTime'] as int,
      createdBy: json['createdBy'] as String,
      listName: json['listName'] as String?,
      members: (json['members'] as List<dynamic>)
          .map((e) => UserResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      tasks: (json['tasks'] as List<dynamic>)
          .map((e) => TaskResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      labels: (json['labels'] as List<dynamic>)
          .map((e) => LabelResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      cardAttachments: (json['cardAttachments'] as List<dynamic>)
          .map((e) => FileResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CardResponseToJson(CardResponse instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'name': instance.name,
      'description': instance.description,
      'position': instance.position,
      'startDate': instance.startDate,
      'dueDate': instance.dueDate,
      'reminder': instance.reminder,
      'listId': instance.listId,
      'isComplete': instance.isComplete,
      'createdTime': instance.createdTime,
      'updatedTime': instance.updatedTime,
      'createdBy': instance.createdBy,
      'listName': instance.listName,
      'members': instance.members,
      'tasks': instance.tasks,
      'labels': instance.labels,
      'cardAttachments': instance.cardAttachments,
    };
