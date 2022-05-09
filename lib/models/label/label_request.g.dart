// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabelRequest _$LabelRequestFromJson(Map<String, dynamic> json) => LabelRequest(
      name: json['name'] as String,
      color: json['color'] as String,
      boardId: json['boardId'] as int,
    );

Map<String, dynamic> _$LabelRequestToJson(LabelRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'color': instance.color,
      'boardId': instance.boardId,
    };
