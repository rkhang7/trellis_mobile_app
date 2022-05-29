import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/models/file/file_response.dart';

class FileRepository {
  void uploadImage(XFile file, int cardId) async {
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    Dio dio = Dio();

    dio
        .post("http://10.0.2.2:8080/storage/uploadFile?cardId=$cardId",
            data: data)
        .then(
      (value) {
        Map<String, dynamic> map = value.data;

        var _item = FileResponse.fromJson(map);

        log(jsonEncode(_item));
      },
    ).catchError(
      (error) => print(error),
    );
  }
}
