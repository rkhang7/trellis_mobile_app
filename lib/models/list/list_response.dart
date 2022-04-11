import 'package:json_annotation/json_annotation.dart';
part 'list_response.g.dart';

@JsonSerializable()
class ListResponse {
  int list_id;
  String name;
  int position;
  int board_id;
  int created_time;
  int updated_time;
  String created_by;

  ListResponse({
    required this.list_id,
    required this.name,
    required this.position,
    required this.board_id,
    required this.created_time,
    required this.updated_time,
    required this.created_by,
  });

  factory ListResponse.fromJson(Map<String, dynamic> json) =>
      _$ListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ListResponseToJson(this);
}
