import 'package:json_annotation/json_annotation.dart';
import 'package:trellis_mobile_app/models/label/label_response.dart';
import 'package:trellis_mobile_app/models/task/task_response.dart';
import 'package:trellis_mobile_app/models/user/user_response.dart';
part 'card_response.g.dart';

@JsonSerializable()
class CardResponse {
  int cardId;
  String name;
  String description;
  int position;
  int startDate;
  int dueDate;
  int reminder;
  int listId;
  bool isComplete;
  int createdTime;
  int updatedTime;
  String createdBy;
  String? listName;
  List<UserResponse> members;
  List<TaskResponse> tasks;
  List<LabelResponse> labels;

  CardResponse({
    required this.cardId,
    required this.name,
    required this.description,
    required this.position,
    required this.startDate,
    required this.dueDate,
    required this.reminder,
    required this.listId,
    required this.isComplete,
    required this.createdTime,
    required this.updatedTime,
    required this.createdBy,
    this.listName,
    required this.members,
    required this.tasks,
    required this.labels,
  });

  factory CardResponse.fromJson(Map<String, dynamic> json) =>
      _$CardResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CardResponseToJson(this);
}
