import 'package:json_annotation/json_annotation.dart';
part 'workspace_request.g.dart';

@JsonSerializable()
class WorkSpaceRequest {
  String name;
  String workspaceType;
  String? description;
  String createdBy;

  WorkSpaceRequest({
    required this.name,
    required this.workspaceType,
    this.description,
    required this.createdBy,
  });

  factory WorkSpaceRequest.fromJson(Map<String, dynamic> json) =>
      _$WorkSpaceRequestFromJson(json);
  Map<String, dynamic> toJson() => _$WorkSpaceRequestToJson(this);
}
