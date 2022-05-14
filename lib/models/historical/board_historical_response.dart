import 'package:json_annotation/json_annotation.dart';
part 'board_historical_response.g.dart';

@JsonSerializable()
class BoardHistoricalResponse {
  int board_id;
  String uid;
  String email;
  String first_name;
  String last_name;
  String avatar_background_color;
  String avatar_url;
  String content;

  BoardHistoricalResponse({
    required this.board_id,
    required this.uid,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.avatar_background_color,
    required this.avatar_url,
    required this.content,
  });

  factory BoardHistoricalResponse.fromJson(Map<String, dynamic> json) =>
      _$BoardHistoricalResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BoardHistoricalResponseToJson(this);
}
