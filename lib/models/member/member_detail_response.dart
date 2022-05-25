import 'package:json_annotation/json_annotation.dart';
part 'member_detail_response.g.dart';

@JsonSerializable()
class MemberDetailResponse {
  String memberId;
  int permission;
  int workspaceId;
  String email;
  String firstName;
  String lastName;
  String avatarBackgroundColor;
  String avatarURL;
  int createdTime;
  int updatedTime;

  MemberDetailResponse(
      {required this.memberId,
      required this.permission,
      required this.workspaceId,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.avatarBackgroundColor,
      required this.avatarURL,
      required this.createdTime,
      required this.updatedTime});

  factory MemberDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$MemberDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MemberDetailResponseToJson(this);
}
