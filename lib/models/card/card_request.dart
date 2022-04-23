import 'package:json_annotation/json_annotation.dart';
part 'card_request.g.dart';

@JsonSerializable()
class CardRequest {
  String name;
  String description;
  int position;
  int startDate;
  int reminder;
  int dueDate;
  int listId;
  String createdBy;

  CardRequest(
      {required this.name,
      required this.description,
      required this.position,
      required this.startDate,
      required this.dueDate,
      required this.reminder,
      required this.listId,
      required this.createdBy});

  factory CardRequest.fromJson(Map<String, dynamic> json) =>
      _$CardRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CardRequestToJson(this);
}
