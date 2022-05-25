// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListResponse _$ListResponseFromJson(Map<String, dynamic> json) => ListResponse(
      listId: json['listId'] as int,
      name: json['name'] as String,
      position: json['position'] as int,
      boardId: json['boardId'] as int,
      createdTime: json['createdTime'] as int,
      updatedTime: json['updatedTime'] as int,
      createdBy: json['createdBy'] as String,
      cards: (json['cards'] as List<dynamic>)
          .map((e) => CardResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListResponseToJson(ListResponse instance) =>
    <String, dynamic>{
      'listId': instance.listId,
      'name': instance.name,
      'position': instance.position,
      'boardId': instance.boardId,
      'createdTime': instance.createdTime,
      'updatedTime': instance.updatedTime,
      'createdBy': instance.createdBy,
      'cards': instance.cards,
    };
