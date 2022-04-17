import 'package:json_annotation/json_annotation.dart';
import 'package:trellis_mobile_app/models/user/user_response.dart';
part 'card_response.g.dart';

@JsonSerializable()
class CardResponse {
  int card_id;
  String name;
  String description;
  int position;
  int start_date;
  int due_date;
  int list_id;
  bool is_complete;
  int created_time;
  int updated_time;
  String created_by;
  List<UserResponse>? members;

  CardResponse({
    required this.card_id,
    required this.name,
    required this.description,
    required this.position,
    required this.start_date,
    required this.due_date,
    required this.list_id,
    required this.is_complete,
    required this.created_time,
    required this.updated_time,
    required this.created_by,
    required this.members,
  });

  factory CardResponse.fromJson(Map<String, dynamic> json) =>
      _$CardResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CardResponseToJson(this);
}
