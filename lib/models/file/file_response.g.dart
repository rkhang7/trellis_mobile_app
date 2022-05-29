// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileResponse _$FileResponseFromJson(Map<String, dynamic> json) => FileResponse(
      id: json['id'] as int,
      cardId: json['cardId'] as int,
      name: json['name'] as String,
      url: json['url'] as String,
      createdTime: json['createdTime'] as int,
      updatedTime: json['updatedTime'] as int,
    );

Map<String, dynamic> _$FileResponseToJson(FileResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cardId': instance.cardId,
      'name': instance.name,
      'url': instance.url,
      'createdTime': instance.createdTime,
      'updatedTime': instance.updatedTime,
    };
