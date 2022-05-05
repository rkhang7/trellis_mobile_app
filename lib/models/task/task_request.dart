import 'package:json_annotation/json_annotation.dart';
part 'task_request.g.dart';

@JsonSerializable()
class TaskRequest {
  String name;
  int position;
  int cardId;
  bool isComplete;
  int createdBy;

  TaskRequest({
    required this.name,
    required this.position,
    required this.cardId,
    required this.isComplete,
    required this.createdBy,
  });

  factory TaskRequest.fromJson(Map<String, dynamic> json) =>
      _$TaskRequestFromJson(json);
  Map<String, dynamic> toJson() => _$TaskRequestToJson(this);
}
