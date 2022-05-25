import 'package:json_annotation/json_annotation.dart';
part 'board_member_detail_response.g.dart';

@JsonSerializable()
class BoardMemberDetailResponse {
  String memberId;
  int permission;
  int boardId;
  String email;
  String firstName;
  String lastName;
  String avatarBackgroundColor;
  String avatarUrl;
  int createdTime;
  int updatedTime;

  BoardMemberDetailResponse(
      {required this.memberId,
      required this.permission,
      required this.boardId,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.avatarBackgroundColor,
      required this.avatarUrl,
      required this.createdTime,
      required this.updatedTime});

  factory BoardMemberDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$BoardMemberDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BoardMemberDetailResponseToJson(this);
}
