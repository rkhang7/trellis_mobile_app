// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_member_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardMemberResponse _$CardMemberResponseFromJson(Map<String, dynamic> json) =>
    CardMemberResponse(
      memberId: json['memberId'] as String,
      cardId: json['cardId'] as int,
      createdTime: json['createdTime'] as int,
      updatedTime: json['updatedTime'] as int,
    );

Map<String, dynamic> _$CardMemberResponseToJson(CardMemberResponse instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'cardId': instance.cardId,
      'createdTime': instance.createdTime,
      'updatedTime': instance.updatedTime,
    };
