import 'package:json_annotation/json_annotation.dart';
part 'member_response.g.dart';

@JsonSerializable()
class MemberResponse {
  String memberId;
  int permission;
  int workspaceId;
  int createdTime;
  int updatedTime;

  MemberResponse(
      {required this.memberId,
      required this.permission,
      required this.workspaceId,
      required this.createdTime,
      required this.updatedTime});

  factory MemberResponse.fromJson(Map<String, dynamic> json) =>
      _$MemberResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MemberResponseToJson(this);
}
