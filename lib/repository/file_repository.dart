import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getX;
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/models/file/file_response.dart';
import 'package:trellis_mobile_app/modules/card/update_card/update_card_controller.dart';

class FileRepository {
  // final updateCardController = getX.Get.find<UpdateCardController>();
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

        // updateCardController.cardUpdate.value.cardAttachments.add(_item);
        // updateCardController.cardUpdate.refresh();

        log(jsonEncode(_item));
      },
    ).catchError(
      (error) => print(error),
    );
  }
}
