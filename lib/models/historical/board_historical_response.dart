import 'package:json_annotation/json_annotation.dart';
part 'board_historical_response.g.dart';

@JsonSerializable()
class BoardHistoricalResponse {
  int boardId;
  String uid;
  String email;
  String firstName;
  String lastName;
  String avatarBackgroundColor;
  String avatarURL;
  String content;
  int createdTime;
  int updatedTime;

  BoardHistoricalResponse({
    required this.boardId,
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatarBackgroundColor,
    required this.avatarURL,
    required this.content,
    required this.createdTime,
    required this.updatedTime,
  });

  factory BoardHistoricalResponse.fromJson(Map<String, dynamic> json) =>
      _$BoardHistoricalResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BoardHistoricalResponseToJson(this);
}
