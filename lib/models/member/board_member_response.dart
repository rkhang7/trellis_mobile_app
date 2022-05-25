import 'package:json_annotation/json_annotation.dart';
part 'board_member_response.g.dart';

@JsonSerializable()
class BoardMemberResponse {
  String memberId;
  int permission;
  int boardId;
  int createdTime;
  int updatedTime;

  BoardMemberResponse(
      {required this.memberId,
      required this.permission,
      required this.boardId,
      required this.createdTime,
      required this.updatedTime});

  factory BoardMemberResponse.fromJson(Map<String, dynamic> json) =>
      _$BoardMemberResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BoardMemberResponseToJson(this);
}
