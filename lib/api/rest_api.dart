import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:trellis_mobile_app/models/board/board_request.dart';
import 'package:trellis_mobile_app/models/board/board_response.dart';
import 'package:trellis_mobile_app/models/card/card_request.dart';
import 'package:trellis_mobile_app/models/card/card_response.dart';
import 'package:trellis_mobile_app/models/historical/board_historical_response.dart';
import 'package:trellis_mobile_app/models/label/label_request.dart';
import 'package:trellis_mobile_app/models/label/label_response.dart';
import 'package:trellis_mobile_app/models/list/list_request.dart';
import 'package:trellis_mobile_app/models/list/list_response.dart';
import 'package:trellis_mobile_app/models/member/board_member_detail_response.dart';
import 'package:trellis_mobile_app/models/member/board_member_request.dart';
import 'package:trellis_mobile_app/models/member/board_member_response.dart';
import 'package:trellis_mobile_app/models/member/card_member_request.dart';
import 'package:trellis_mobile_app/models/member/card_member_response.dart';
import 'package:trellis_mobile_app/models/member/member_detail_response.dart';
import 'package:trellis_mobile_app/models/member/member_request.dart';
import 'package:trellis_mobile_app/models/member/member_response.dart';
import 'package:trellis_mobile_app/models/statistics/statistics_response.dart';
import 'package:trellis_mobile_app/models/task/task_request.dart';
import 'package:trellis_mobile_app/models/task/task_response.dart';
import 'package:trellis_mobile_app/models/user/user_request.dart';
import 'package:trellis_mobile_app/models/user/user_response.dart';
import 'package:trellis_mobile_app/models/workspace/workspace_request.dart';
import 'package:trellis_mobile_app/models/workspace/workspace_response.dart';

part 'rest_api.g.dart';

@RestApi(baseUrl: "http://ec2-54-144-207-65.compute-1.amazonaws.com:8080")
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

  @PUT("/users/{uid}")
  Future<UserResponse> updateUser(
      @Path("uid") String uid, @Body() UserRequest userRequest);

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

  @DELETE("/workspaces/{workspaceId}")
  Future<void> deleteWorkspace(
    @Path("workspaceId") int workspaceId,
  );

  // member
  @POST("/members")
  Future<MemberResponse> createMemberIntoWorkspace(
      @Body() MemberRequest memberRequest);

  @POST("/members/adds")
  Future<List<MemberResponse>> inviteMulti(
      @Body() List<MemberRequest> listMemberRequest);

  @DELETE("/members/{uid}/{workspaceId}")
  Future<void> removeMemberFromWorkspace(
      @Path("uid") String uid, @Path("workspaceId") int workspaceId);

  @GET("/members")
  Future<List<MemberDetailResponse>> getListMemberInWorkspace(
      @Query("workspace") int workspaceId);

  @GET("/board-members")
  Future<List<BoardMemberDetailResponse>> getListMemberInBoard(
      @Query("boardId") int boardId);

  @POST("/board-members/adds")
  Future<List<BoardMemberResponse>> inviteMultiBoard(
      @Body() List<BoardMemberRequest> listBoardMemberRequest);

  @DELETE("/board-members/{memberId}/{boardId}")
  Future<void> removeMemberFromBoard(
      @Path("memberId") String memberId, @Path("boardId") int boardId);

  @POST("/card-member")
  Future<UserResponse> createMemberIntoCard(
      @Body() CardMemberRequest cardMemberRequest, @Query("uid") String uid);

  @DELETE("/card-member/{memberId}/{cardId}")
  Future<void> removeMemberInCard(@Path("memberId") String memberId,
      @Path("cardId") int cardId, @Query("uid") String uid);

  // board
  @POST("/boards")
  Future<BoardResponse> createBoard(@Body() BoardRequest boardRequest);

  @GET("/boards/workspace/{workspaceId}/user/{uid}")
  Future<List<BoardResponse>> getListBoardsInWorkspace(
    @Path("workspaceId") int workspaceId,
    @Path("uid") String uid,
    @Query("name") String name,
  );

  @GET("/boards/{boardId}")
  Future<BoardResponse> getBoardById(@Path("boardId") int boardId);

  @PUT("/boards/{boardId}")
  Future<BoardResponse> updateBoard(
      @Path("boardId") int boardId, @Body() BoardRequest boardRequest);

  @DELETE("/boards/{boardId}")
  Future<void> deleteBoard(@Path("boardId") int boardId);

  @GET("/boards/filter")
  Future<List<BoardResponse>> getBoardByDate(
      @Query("uid") String uid, @Query("date") int date);

  @GET("/boards/in/{uid}/{boardId}")
  Future<List<CardResponse>> getCardsInBoard(
      @Path("uid") String uid, @Path("boardId") int boardId);

  // list
  @POST("/board-list")
  Future<ListResponse> createList(@Body() ListRequest listRequest);

  @GET("/board-list")
  Future<List<ListResponse>> getListsInBoard(@Query("boardId") int boardId);

  @PUT("/board-list/{listId}")
  Future<ListResponse> updateList(
      @Path("listId") int listId, @Body() ListRequest listRequest);

  @DELETE("/board-list/{listId}")
  Future<void> deleteList(@Path("listId") int listId, @Query("uid") String uid);

  // card
  @POST("/cards")
  Future<CardResponse> createCard(@Body() CardRequest cardRequest);

  @GET("/cards/{listId}/move/{oldIndex}/{newIndex}")
  Future<String> moveCards(
    @Path("listId") int listId,
    @Path("oldIndex") int oldIndex,
    @Path("newIndex") int newIndex,
  );

  @PUT("/cards/{cardId}")
  Future<CardResponse> updateCard(
      @Path("cardId") int cardId, @Body() CardRequest cardRequest);

  @GET("/cards/sort/{listId}")
  Future<List<CardResponse>> sort(
      @Path("listId") int listId, @Query("sort") String sort);

  @DELETE("/cards/{cardId}")
  Future<String> deleteCard(
      @Path("cardId") int cardId, @Query("uid") String uid);

  @GET("/cards/statistics/{uid}")
  Future<StatisticsResponse> getStatistics(
    @Path("uid") String uid,
    @Query("fromTime") int fromTime,
    @Query("toTime") int toTime,
  );

  //task
  @POST("/tasks")
  Future<TaskResponse> createTask(@Body() TaskRequest taskRequest);

  @PUT("/tasks/{taskId}")
  Future<TaskResponse> updateTask(
      @Path("taskId") int taskId, @Body() TaskRequest taskRequest);

  @DELETE("/tasks/{taskId}")
  Future<String> deleteTask(
      @Path("taskId") int taskId, @Query("uid") String uid);

  @GET("/tasks/{cardId}/move/{oldIndex}/{newIndex}")
  Future<String> moveTasks(
    @Path("cardId") int cardId,
    @Path("oldIndex") int oldIndex,
    @Path("newIndex") int newIndex,
  );

  // label
  @POST("/labels")
  Future<LabelResponse> createLabel(@Body() LabelRequest labelRequest);

  @GET("/labels")
  Future<List<LabelResponse>> getLabelsInBoard(@Query("boardId") int boardId);

  @PUT("/labels/{labelId}")
  Future<LabelResponse> updateLabel(
      @Path("labelId") int labelId, @Body() LabelRequest labelRequest);

  @DELETE("/labels{labelId}")
  Future<String> deleteLabel(@Path("labelId") int labelId);

  // historical
  @GET("/board-historical/{boardId}")
  Future<List<BoardHistoricalResponse>> getBoardHistoricalInBoard(
      @Path("boardId") int boardId);

  // file

}
