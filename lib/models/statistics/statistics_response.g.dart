// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticsResponse _$StatisticsResponseFromJson(Map<String, dynamic> json) =>
    StatisticsResponse(
      total: json['total'] as int,
      completed: json['completed'] as int,
      inCompleted: json['inCompleted'] as int,
    );

Map<String, dynamic> _$StatisticsResponseToJson(StatisticsResponse instance) =>
    <String, dynamic>{
      'total': instance.total,
      'completed': instance.completed,
      'inCompleted': instance.inCompleted,
    };
