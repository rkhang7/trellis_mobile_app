import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:trellis_mobile_app/models/board/board_request.dart';
import 'package:trellis_mobile_app/models/board/board_response.dart';
import 'package:trellis_mobile_app/models/list/list_request.dart';
import 'package:trellis_mobile_app/models/list/list_response.dart';
import 'package:trellis_mobile_app/models/member/board_member_detail_response.dart';
import 'package:trellis_mobile_app/models/member/board_member_request.dart';
import 'package:trellis_mobile_app/models/member/board_member_response.dart';
import 'package:trellis_mobile_app/models/member/member_detail_response.dart';
import 'package:trellis_mobile_app/models/member/member_request.dart';
import 'package:trellis_mobile_app/models/member/member_response.dart';
import 'package:trellis_mobile_app/models/user/user_request.dart';
import 'package:trellis_mobile_app/models/user/user_response.dart';
import 'package:trellis_mobile_app/models/workspace/workspace_request.dart';
import 'package:trellis_mobile_app/models/workspace/workspace_response.dart';

part 'rest_api.g.dart';

@RestApi(baseUrl: "http://192.168.40.82:8080/")
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
      @Query("keyword") String keyword,
      @Query("workspace") int workspace,
      @Query("board") int boardId);

  // workspace
  @POST("/workspaces")
  Future<WorkSpaceResponse> createWorkspace(
      @Body() WorkSpaceRequest workSpaceRequest);

  @GET("/workspaces")
  Future<List<WorkSpaceResponse>> getWorkspacesByUid(@Query("user") String uid);

  @PUT("/workspaces/{workspaceId}")
  Future<WorkSpaceResponse> updateWorkspace(
      @Path("workspaceId") int workspaceId,
      @Body() WorkSpaceRequest workSpaceRequest);

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

  @DELETE("/members/{uid}/{workspaceId}")
  Future<void> removeMemberFromWorkspace(
      @Path("uid") String uid, @Path("workspaceId") int workspaceId);

  @GET("/board-members")
  Future<List<BoardMemberDetailResponse>> getListMemberInBoard(
      @Query("boardId") int boardId);

  @POST("/board-members/adds")
  Future<List<BoardMemberResponse>> inviteMultiBoard(
      @Body() List<BoardMemberRequest> listBoardMemberRequest);

  // board
  @POST("/boards")
  Future<BoardResponse> createBoard(@Body() BoardRequest boardRequest);

  @GET("/boards/workspace/{workspaceId}/user/{uid}")
  Future<List<BoardResponse>> getListBoardsInWorkspace(
      @Path("workspaceId") int workspaceId, @Path("uid") String uid);

  @GET("/boards/{boardId}")
  Future<BoardResponse> getBoardById(@Path("boardId") int boardId);

  // list
  @POST("/board-list")
  Future<ListResponse> createList(@Body() ListRequest listRequest);

  @GET("/board-list")
  Future<List<ListResponse>> getListsInBoard(@Query("boardId") int boardId);

  @PUT("/board-list/{listId}")
  Future<ListResponse> updateList(
      @Path("listId") int listId, @Body() ListRequest listRequest);
}
