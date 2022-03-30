import 'package:json_annotation/json_annotation.dart';
part 'user_request.g.dart';

@JsonSerializable()
class UserRequest {
  String uid;
  String email;
  String firstName;
  String lastName;
  String avatarBackgroundColor;
  String avatarURL;

  UserRequest({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatarBackgroundColor,
    required this.avatarURL,
  });

  factory UserRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UserRequestToJson(this);
}
