import 'package:json_annotation/json_annotation.dart';
part 'board_member_response.g.dart';

@JsonSerializable()
class BoardMemberResponse {
  String member_id;
  int permission;
  int board_id;
  int created_time;
  int updated_time;

  BoardMemberResponse(
      {required this.member_id,
      required this.permission,
      required this.board_id,
      required this.created_time,
      required this.updated_time});

  factory BoardMemberResponse.fromJson(Map<String, dynamic> json) =>
      _$BoardMemberResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BoardMemberResponseToJson(this);
}
