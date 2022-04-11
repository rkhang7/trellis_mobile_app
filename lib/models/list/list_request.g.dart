// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListRequest _$ListRequestFromJson(Map<String, dynamic> json) => ListRequest(
      name: json['name'] as String,
      position: json['position'] as int,
      boardId: json['boardId'] as int,
      createdBy: json['createdBy'] as String,
    );

Map<String, dynamic> _$ListRequestToJson(ListRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'position': instance.position,
      'boardId': instance.boardId,
      'createdBy': instance.createdBy,
    };
