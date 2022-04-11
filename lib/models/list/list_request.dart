import 'package:json_annotation/json_annotation.dart';
part 'list_request.g.dart';

@JsonSerializable()
class ListRequest {
  String name;
  int position;
  int boardId;
  String createdBy;

  ListRequest({
    required this.name,
    required this.position,
    required this.boardId,
    required this.createdBy,
  });

  factory ListRequest.fromJson(Map<String, dynamic> json) =>
      _$ListRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ListRequestToJson(this);
}
