import 'package:json_annotation/json_annotation.dart';
part 'card_member_request.g.dart';

@JsonSerializable()
class CardMemberRequest {
  String memberId;
  int cardId;

  CardMemberRequest({
    required this.memberId,
    required this.cardId,
  });

  factory CardMemberRequest.fromJson(Map<String, dynamic> json) =>
      _$CardMemberRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CardMemberRequestToJson(this);
}
