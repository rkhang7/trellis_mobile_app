import 'package:dio/dio.dart';
import 'package:trellis_mobile_app/api/rest_api.dart';
import 'package:trellis_mobile_app/models/user/user_request.dart';
import 'package:trellis_mobile_app/models/user/user_response.dart';

class UserRepository {
  final dio = Dio(); // Provide a dio instance

  Future<UserResponse> getUserById(String uid) async {
    final client = RestClient(dio);
    return await client.getUserById(uid);
  }

  Future<UserResponse> createUser(UserRequest user) async {
    final client = RestClient(dio);
    return await client.createUser(user);
  }
}
