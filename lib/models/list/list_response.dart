import 'package:json_annotation/json_annotation.dart';
import 'package:trellis_mobile_app/models/card/card_response.dart';
part 'list_response.g.dart';

@JsonSerializable()
class ListResponse {
  int listId;
  String name;
  int position;
  int boardId;
  int createdTime;
  int updatedTime;
  String createdBy;
  List<CardResponse> cards;

  ListResponse({
    required this.listId,
    required this.name,
    required this.position,
    required this.boardId,
    required this.createdTime,
    required this.updatedTime,
    required this.createdBy,
    required this.cards,
  });

  factory ListResponse.fromJson(Map<String, dynamic> json) =>
      _$ListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ListResponseToJson(this);
}
