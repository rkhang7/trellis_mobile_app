import 'package:json_annotation/json_annotation.dart';
part 'board_request.g.dart';

@JsonSerializable()
class BoardRequest {
  String name;
  String description;
  bool closed;
  int visibility;
  int workspaceId;
  String createdBy;
  String backgroundColor;
  String backgroundDarkColor;

  BoardRequest({
    required this.name,
    required this.description,
    required this.closed,
    required this.visibility,
    required this.workspaceId,
    required this.createdBy,
    required this.backgroundColor,
    required this.backgroundDarkColor,
  });

  factory BoardRequest.fromJson(Map<String, dynamic> json) =>
      _$BoardRequestFromJson(json);
  Map<String, dynamic> toJson() => _$BoardRequestToJson(this);
}
