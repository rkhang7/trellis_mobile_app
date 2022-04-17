// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListResponse _$ListResponseFromJson(Map<String, dynamic> json) => ListResponse(
      list_id: json['list_id'] as int,
      name: json['name'] as String,
      position: json['position'] as int,
      board_id: json['board_id'] as int,
      created_time: json['created_time'] as int,
      updated_time: json['updated_time'] as int,
      created_by: json['created_by'] as String,
      cards: (json['cards'] as List<dynamic>)
          .map((e) => CardResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListResponseToJson(ListResponse instance) =>
    <String, dynamic>{
      'list_id': instance.list_id,
      'name': instance.name,
      'position': instance.position,
      'board_id': instance.board_id,
      'created_time': instance.created_time,
      'updated_time': instance.updated_time,
      'created_by': instance.created_by,
      'cards': instance.cards,
    };
