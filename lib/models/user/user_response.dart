import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  String uid;
  String email;
  String firstName;
  String lastName;
  String avatarBackgroundColor;
  String avatarURL;
  int createdTime;
  int updatedTime;
  String? token;

  UserResponse({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatarBackgroundColor,
    required this.avatarURL,
    required this.createdTime,
    required this.updatedTime,
    this.token,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  @override
  String toString() {
    return 'UserResponse(uid: $uid, email: $email, first_name: $firstName, last_name: $lastName, avatar_background_color: $avatarBackgroundColor, created_time: $createdTime, updated_time: $updatedTime)';
  }
}
