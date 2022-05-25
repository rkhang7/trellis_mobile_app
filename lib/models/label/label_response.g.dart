// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabelResponse _$LabelResponseFromJson(Map<String, dynamic> json) =>
    LabelResponse(
      labelId: json['labelId'] as int,
      name: json['name'] as String,
      color: json['color'] as String,
      boardId: json['boardId'] as int,
      createdTime: json['createdTime'] as int,
      updatedTime: json['updatedTime'] as int,
    );

Map<String, dynamic> _$LabelResponseToJson(LabelResponse instance) =>
    <String, dynamic>{
      'labelId': instance.labelId,
      'name': instance.name,
      'color': instance.color,
      'boardId': instance.boardId,
      'createdTime': instance.createdTime,
      'updatedTime': instance.updatedTime,
    };
