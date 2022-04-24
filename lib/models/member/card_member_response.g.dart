// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_member_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardMemberResponse _$CardMemberResponseFromJson(Map<String, dynamic> json) =>
    CardMemberResponse(
      member_id: json['member_id'] as String,
      card_id: json['card_id'] as int,
      created_time: json['created_time'] as int,
      updated_time: json['updated_time'] as int,
    );

Map<String, dynamic> _$CardMemberResponseToJson(CardMemberResponse instance) =>
    <String, dynamic>{
      'member_id': instance.member_id,
      'card_id': instance.card_id,
      'created_time': instance.created_time,
      'updated_time': instance.updated_time,
    };
