import 'package:json_annotation/json_annotation.dart';
part 'file_response.g.dart';

@JsonSerializable()
class FileResponse {
  int id;
  int cardId;
  String name;
  String url;
  int createdTime;
  int updatedTime;

  FileResponse({
    required this.id,
    required this.cardId,
    required this.name,
    required this.url,
    required this.createdTime,
    required this.updatedTime,
  });

  factory FileResponse.fromJson(Map<String, dynamic> json) =>
      _$FileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FileResponseToJson(this);
}
