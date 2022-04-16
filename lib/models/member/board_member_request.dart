import 'package:json_annotation/json_annotation.dart';
part 'board_member_request.g.dart';

@JsonSerializable()
class BoardMemberRequest {
  String memberId;
  int permission;
  int boardId;

  BoardMemberRequest({
    required this.memberId,
    required this.permission,
    required this.boardId,
  });

  factory BoardMemberRequest.fromJson(Map<String, dynamic> json) =>
      _$BoardMemberRequestFromJson(json);
  Map<String, dynamic> toJson() => _$BoardMemberRequestToJson(this);
}
