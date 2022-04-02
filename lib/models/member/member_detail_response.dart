import 'package:json_annotation/json_annotation.dart';
part 'member_detail_response.g.dart';

@JsonSerializable()
class MemberDetailResponse {
  String member_id;
  int permission;
  int workspace_id;
  String email;
  String first_name;
  String last_name;
  String avatar_background_color;
  String avatar_url;
  int created_time;
  int updated_time;

  MemberDetailResponse(
      {required this.member_id,
      required this.permission,
      required this.workspace_id,
      required this.email,
      required this.first_name,
      required this.last_name,
      required this.avatar_background_color,
      required this.avatar_url,
      required this.created_time,
      required this.updated_time});

  factory MemberDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$MemberDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MemberDetailResponseToJson(this);
}
