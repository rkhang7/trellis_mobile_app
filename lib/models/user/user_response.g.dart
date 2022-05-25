// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      uid: json['uid'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      avatarBackgroundColor: json['avatarBackgroundColor'] as String,
      avatarURL: json['avatarURL'] as String,
      createdTime: json['createdTime'] as int,
      updatedTime: json['updatedTime'] as int,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avatarBackgroundColor': instance.avatarBackgroundColor,
      'avatarURL': instance.avatarURL,
      'createdTime': instance.createdTime,
      'updatedTime': instance.updatedTime,
      'token': instance.token,
    };
