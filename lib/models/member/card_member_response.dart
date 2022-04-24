import 'package:json_annotation/json_annotation.dart';
part 'card_member_response.g.dart';

@JsonSerializable()
class CardMemberResponse {
  String member_id;
  int card_id;
  int created_time;
  int updated_time;

  CardMemberResponse({
    required this.member_id,
    required this.card_id,
    required this.created_time,
    required this.updated_time,
  });

  factory CardMemberResponse.fromJson(Map<String, dynamic> json) =>
      _$CardMemberResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CardMemberResponseToJson(this);
}
