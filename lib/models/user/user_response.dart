import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  String uid;
  String email;
  String first_name;
  String last_name;
  String avatar_background_color;
  int created_time;
  int updated_time;

  UserResponse({
    required this.uid,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.avatar_background_color,
    required this.created_time,
    required this.updated_time,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
