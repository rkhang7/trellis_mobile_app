import 'package:json_annotation/json_annotation.dart';
part 'card_member_response.g.dart';

@JsonSerializable()
class CardMemberResponse {
  String memberId;
  int cardId;
  int createdTime;
  int updatedTime;

  CardMemberResponse({
    required this.memberId,
    required this.cardId,
    required this.createdTime,
    required this.updatedTime,
  });

  factory CardMemberResponse.fromJson(Map<String, dynamic> json) =>
      _$CardMemberResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CardMemberResponseToJson(this);
}
