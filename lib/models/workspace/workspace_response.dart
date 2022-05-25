import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'workspace_response.g.dart';

@JsonSerializable()
class WorkSpaceResponse {
  int workspaceId;
  String name;
  String workspaceType;
  String description;
  bool closed;
  int createdTime;
  int updatedTime;
  String createdBy;

  WorkSpaceResponse({
    required this.workspaceId,
    required this.name,
    required this.workspaceType,
    required this.description,
    required this.closed,
    required this.createdTime,
    required this.updatedTime,
    required this.createdBy,
  });

  factory WorkSpaceResponse.fromJson(Map<String, dynamic> json) =>
      _$WorkSpaceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WorkSpaceResponseToJson(this);

  @override
  String toString() {
    return 'WorkSpaceResponse(workspace_id: $workspaceId, name: $name, workspace_type: $workspaceType, description: $description, created_time: $createdTime, updated_time: $updatedTime, created_by: $createdBy)';
  }
}
