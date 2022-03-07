import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:trellis_mobile_app/models/user/user_request.dart';
import 'package:trellis_mobile_app/models/user/user_response.dart';

part 'rest_api.g.dart';

@RestApi(baseUrl: "http://192.168.212.104:8080/")
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) {
    dio.options = BaseOptions(receiveTimeout: 60000, connectTimeout: 60000);
    return _RestClient(dio);
  }

  @GET("/user/{uid}")
  Future<UserResponse> getUserById(@Path() String uid);

  @POST("/user")
  Future<UserResponse> createUser(@Body() UserRequest user);
}
