import 'package:json_annotation/json_annotation.dart';
part 'task_response.g.dart';

@JsonSerializable()
class TaskResponse {
  int task_id;
  String name;
  int position;
  int card_id;
  bool is_complete;
  int created_time;
  int updated_time;
  String created_by;

  TaskResponse({
    required this.task_id,
    required this.name,
    required this.position,
    required this.card_id,
    required this.is_complete,
    required this.created_time,
    required this.updated_time,
    required this.created_by,
  });

  factory TaskResponse.fromJson(Map<String, dynamic> json) =>
      _$TaskResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TaskResponseToJson(this);
}
