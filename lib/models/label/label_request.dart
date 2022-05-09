import 'package:json_annotation/json_annotation.dart';
part 'label_request.g.dart';

@JsonSerializable()
class LabelRequest {
  String name;
  String color;
  int boardId;

  LabelRequest({
    required this.name,
    required this.color,
    required this.boardId,
  });

  factory LabelRequest.fromJson(Map<String, dynamic> json) =>
      _$LabelRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LabelRequestToJson(this);
}
