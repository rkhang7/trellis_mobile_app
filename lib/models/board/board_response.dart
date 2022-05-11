import 'package:json_annotation/json_annotation.dart';
import 'package:trellis_mobile_app/models/card/card_response.dart';
import 'package:trellis_mobile_app/models/list/list_response.dart';
part 'board_response.g.dart';

@JsonSerializable()
class BoardResponse {
  int board_id;
  String name;
  String description;
  bool closed;
  int visibility;
  int workspace_id;
  int created_time;
  int updated_time;
  String created_by;
  String background_color;
  String background_dark_color;
  List<ListResponse> board_list_resps;

  BoardResponse({
    required this.board_id,
    required this.name,
    required this.description,
    required this.closed,
    required this.workspace_id,
    required this.visibility,
    required this.created_time,
    required this.updated_time,
    required this.created_by,
    required this.background_color,
    required this.background_dark_color,
    required this.board_list_resps,
  });

  factory BoardResponse.fromJson(Map<String, dynamic> json) =>
      _$BoardResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BoardResponseToJson(this);
}
