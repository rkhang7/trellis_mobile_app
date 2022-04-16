import 'package:json_annotation/json_annotation.dart';
part 'board_member_detail_response.g.dart';

@JsonSerializable()
class BoardMemberDetailResponse {
  String member_id;
  int permission;
  int board_id;
  String email;
  String first_name;
  String last_name;
  String avatar_background_color;
  String avatar_url;
  int created_time;
  int updated_time;

  BoardMemberDetailResponse(
      {required this.member_id,
      required this.permission,
      required this.board_id,
      required this.email,
      required this.first_name,
      required this.last_name,
      required this.avatar_background_color,
      required this.avatar_url,
      required this.created_time,
      required this.updated_time});

  factory BoardMemberDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$BoardMemberDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BoardMemberDetailResponseToJson(this);
}
