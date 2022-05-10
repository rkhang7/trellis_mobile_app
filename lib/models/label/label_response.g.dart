// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabelResponse _$LabelResponseFromJson(Map<String, dynamic> json) =>
    LabelResponse(
      label_id: json['label_id'] as int,
      name: json['name'] as String,
      color: json['color'] as String,
      board_id: json['board_id'] as int,
      created_time: json['created_time'] as int,
      updated_time: json['updated_time'] as int,
    );

Map<String, dynamic> _$LabelResponseToJson(LabelResponse instance) =>
    <String, dynamic>{
      'label_id': instance.label_id,
      'name': instance.name,
      'color': instance.color,
      'board_id': instance.board_id,
      'created_time': instance.created_time,
      'updated_time': instance.updated_time,
    };
