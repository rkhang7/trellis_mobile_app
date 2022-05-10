import 'package:json_annotation/json_annotation.dart';
part 'label_response.g.dart';

@JsonSerializable()
class LabelResponse {
  int label_id;
  String name;
  String color;
  int board_id;
  int created_time;
  int updated_time;

  LabelResponse({
    required this.label_id,
    required this.name,
    required this.color,
    required this.board_id,
    required this.created_time,
    required this.updated_time,
  });

  factory LabelResponse.fromJson(Map<String, dynamic> json) =>
      _$LabelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LabelResponseToJson(this);
}
