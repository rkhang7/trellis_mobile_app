import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:trellis_mobile_app/models/board/board_request.dart';
import 'package:trellis_mobile_app/models/board/board_response.dart';
import 'package:trellis_mobile_app/models/member/member_detail_response.dart';
import 'package:trellis_mobile_app/models/member/member_request.dart';
import 'package:trellis_mobile_app/models/member/member_response.dart';
import 'package:trellis_mobile_app/models/user/user_request.dart';
import 'package:trellis_mobile_app/models/user/user_response.dart';
import 'package:trellis_mobile_app/models/workspace/workspace_request.dart';
import 'package:trellis_mobile_app/models/workspace/workspace_response.dart';

part 'rest_api.g.dart';

@RestApi(baseUrl: "http://192.168.1.25:8080/")
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) {
    dio.options = BaseOptions(receiveTimeout: 60000, connectTimeout: 60000);
    return _RestClient(dio);
  }

  // user
  @GET("/users/{uid}")
  Future<UserResponse> getUserById(@Path() String uid);

  @POST("/users")
  Future<UserResponse> createUser(@Body() UserRequest user);

  @GET("/users/search")
  Future<List<UserResponse>> searchUserInWorkspace(
      @Query("keyword") String keyword, @Query("workspace") int workspace);

  // workspace
  @POST("/workspaces")
  Future<WorkSpaceResponse> createWorkspace(
      @Body() WorkSpaceRequest workSpaceRequest);

  @GET("/workspaces")
  Future<List<WorkSpaceResponse>> getWorkspacesByUid(@Query("user") String uid);

  // member
  @POST("/members")
  Future<MemberResponse> createMemberIntoWorkspace(
      @Body() MemberRequest memberRequest);

  @GET("members")
  Future<List<MemberDetailResponse>> getListMemberInWorkspace(
      @Query("workspace") int workspaceId);

  @POST("/members/adds")
  Future<List<MemberResponse>> inviteMulti(
      @Body() List<MemberRequest> listMemberRequest);

  // board
  @POST("/boards")
  Future<BoardResponse> createBoard(@Body() BoardRequest boardRequest);

  @GET("/boards/workspace/{workspaceId}/user/{uid}")
  Future<List<BoardResponse>> getListBoardsInWorkspace(
      @Path("workspaceId") int workspaceId, @Path("uid") String uid);
}
