import 'package:json_annotation/json_annotation.dart';
part 'label_response.g.dart';

@JsonSerializable()
class LabelResponse {
  int labelId;
  String name;
  String color;
  int boardId;
  int createdTime;
  int updatedTime;

  LabelResponse({
    required this.labelId,
    required this.name,
    required this.color,
    required this.boardId,
    required this.createdTime,
    required this.updatedTime,
  });

  factory LabelResponse.fromJson(Map<String, dynamic> json) =>
      _$LabelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LabelResponseToJson(this);
}
