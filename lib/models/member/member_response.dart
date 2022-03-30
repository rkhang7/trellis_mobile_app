import 'package:json_annotation/json_annotation.dart';
part 'member_response.g.dart';

@JsonSerializable()
class MemberResponse {
  String member_id;
  String permission;
  String workspace_id;
  int created_time;
  int updated_time;

  MemberResponse(
      {required this.member_id,
      required this.permission,
      required this.workspace_id,
      required this.created_time,
      required this.updated_time});

  factory MemberResponse.fromJson(Map<String, dynamic> json) =>
      _$MemberResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MemberResponseToJson(this);
}
