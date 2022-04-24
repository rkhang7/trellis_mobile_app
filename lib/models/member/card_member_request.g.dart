// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_member_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardMemberRequest _$CardMemberRequestFromJson(Map<String, dynamic> json) =>
    CardMemberRequest(
      memberId: json['memberId'] as String,
      cardId: json['cardId'] as int,
    );

Map<String, dynamic> _$CardMemberRequestToJson(CardMemberRequest instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'cardId': instance.cardId,
    };
