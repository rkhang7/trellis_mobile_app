import 'package:json_annotation/json_annotation.dart';
part 'statistics_response.g.dart';

@JsonSerializable()
class StatisticsResponse {
  int total;
  int completed;
  int inCompleted;

  StatisticsResponse({
    required this.total,
    required this.completed,
    required this.inCompleted,
  });

  factory StatisticsResponse.fromJson(Map<String, dynamic> json) =>
      _$StatisticsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StatisticsResponseToJson(this);
}
