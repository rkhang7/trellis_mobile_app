import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  String uid;
  String email;
  String first_name;
  String last_name;
  String avatar_background_color;
  String avatar_url;
  int created_time;
  int updated_time;

  UserResponse({
    required this.uid,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.avatar_background_color,
    required this.avatar_url,
    required this.created_time,
    required this.updated_time,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  @override
  String toString() {
    return 'UserResponse(uid: $uid, email: $email, first_name: $first_name, last_name: $last_name, avatar_background_color: $avatar_background_color, created_time: $created_time, updated_time: $updated_time)';
  }
}
