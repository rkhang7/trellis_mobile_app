import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'workspace_response.g.dart';

@JsonSerializable()
class WorkSpaceResponse {
  int workspace_id;
  String name;
  String workspace_type;
  String description;
  int created_time;
  int updated_time;
  String created_by;

  WorkSpaceResponse({
    required this.workspace_id,
    required this.name,
    required this.workspace_type,
    required this.description,
    required this.created_time,
    required this.updated_time,
    required this.created_by,
  });

  factory WorkSpaceResponse.fromJson(Map<String, dynamic> json) =>
      _$WorkSpaceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WorkSpaceResponseToJson(this);

  @override
  String toString() {
    return 'WorkSpaceResponse(workspace_id: $workspace_id, name: $name, workspace_type: $workspace_type, description: $description, created_time: $created_time, updated_time: $updated_time, created_by: $created_by)';
  }
}
