import 'package:json_annotation/json_annotation.dart';
part 'board_historical_request.g.dart';

@JsonSerializable()
class BoardHistoricalRequest {
  int boardId;
  String uid;
  String action;
  String source;
  String content;

  BoardHistoricalRequest({
    required this.boardId,
    required this.uid,
    required this.action,
    required this.source,
    required this.content,
  });

  factory BoardHistoricalRequest.fromJson(Map<String, dynamic> json) =>
      _$BoardHistoricalRequestFromJson(json);
  Map<String, dynamic> toJson() => _$BoardHistoricalRequestToJson(this);
}
