import 'package:json_annotation/json_annotation.dart';
part 'task_response.g.dart';

@JsonSerializable()
class TaskResponse {
  int taskId;
  String name;
  int position;
  int cardId;
  bool isComplete;
  int createdTime;
  int updatedTime;
  String createdBy;

  TaskResponse({
    required this.taskId,
    required this.name,
    required this.position,
    required this.cardId,
    required this.isComplete,
    required this.createdTime,
    required this.updatedTime,
    required this.createdBy,
  });

  factory TaskResponse.fromJson(Map<String, dynamic> json) =>
      _$TaskResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TaskResponseToJson(this);
}
