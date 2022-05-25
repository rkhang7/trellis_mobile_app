import 'package:json_annotation/json_annotation.dart';
import 'package:trellis_mobile_app/models/list/list_response.dart';
part 'board_response.g.dart';

@JsonSerializable()
class BoardResponse {
  int boardId;
  String name;
  String description;
  bool closed;
  int visibility;
  int workspaceId;
  int createdTime;
  int updatedTime;
  String createdBy;
  String backgroundColor;
  String backgroundDarkColor;
  List<ListResponse> boardListResps;

  BoardResponse({
    required this.boardId,
    required this.name,
    required this.description,
    required this.closed,
    required this.workspaceId,
    required this.visibility,
    required this.createdTime,
    required this.updatedTime,
    required this.createdBy,
    required this.backgroundColor,
    required this.backgroundDarkColor,
    required this.boardListResps,
  });

  factory BoardResponse.fromJson(Map<String, dynamic> json) =>
      _$BoardResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BoardResponseToJson(this);
}
