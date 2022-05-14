// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardRequest _$CardRequestFromJson(Map<String, dynamic> json) => CardRequest(
      name: json['name'] as String,
      description: json['description'] as String,
      position: json['position'] as int,
      startDate: json['startDate'] as int,
      dueDate: json['dueDate'] as int,
      reminder: json['reminder'] as int,
      listId: json['listId'] as int,
      createdBy: json['createdBy'] as String,
      isComplete: json['isComplete'] as bool,
    );

Map<String, dynamic> _$CardRequestToJson(CardRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'position': instance.position,
      'startDate': instance.startDate,
      'reminder': instance.reminder,
      'dueDate': instance.dueDate,
      'listId': instance.listId,
      'createdBy': instance.createdBy,
      'isComplete': instance.isComplete,
    };
