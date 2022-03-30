import 'package:json_annotation/json_annotation.dart';
part 'member_request.g.dart';

@JsonSerializable()
class MemberRequest {
  String memberId;
  String permission;
  String workspaceId;

  MemberRequest({
    required this.memberId,
    required this.permission,
    required this.workspaceId,
  });

  factory MemberRequest.fromJson(Map<String, dynamic> json) =>
      _$MemberRequestFromJson(json);
  Map<String, dynamic> toJson() => _$MemberRequestToJson(this);
}
