import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' as getX;
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/models/file/file_response.dart';
import 'package:trellis_mobile_app/modules/card/update_card/update_card_controller.dart';

class FileRepository {
  final updateCardController = getX.Get.find<UpdateCardController>();
  void uploadImage(XFile file, int cardId) async {
    EasyLoading.show(status: "please_wait".tr);
    FileResponse fileResponse = FileResponse(
        id: -1,
        cardId: -1,
        name: "",
        url: "url",
        createdTime: 1,
        updatedTime: 1);
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    Dio dio = Dio();

    await dio
        .post(
            "http://ec2-54-144-207-65.compute-1.amazonaws.com:8080/storage/uploadFile?cardId=$cardId",
            data: data)
        .then(
      (value) {
        Map<String, dynamic> map = value.data;

        var _item = FileResponse.fromJson(map);

        fileResponse = _item;
        EasyLoading.dismiss();
        log(jsonEncode(fileResponse));
      },
    );

    updateCardController.cardUpdate.value.cardAttachments
        .insert(0, fileResponse);
    updateCardController.cardUpdate.refresh();
  }

  void uploadFile(File file, int cardId) async {
    EasyLoading.show(status: "please_wait".tr);
    FileResponse fileResponse = FileResponse(
        id: -1,
        cardId: -1,
        name: "",
        url: "url",
        createdTime: 1,
        updatedTime: 1);
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    Dio dio = Dio();

    await dio
        .post(
            "http://ec2-54-144-207-65.compute-1.amazonaws.com:8080/storage/uploadFile?cardId=$cardId",
            data: data)
        .then(
      (value) {
        Map<String, dynamic> map = value.data;

        var _item = FileResponse.fromJson(map);

        fileResponse = _item;

        EasyLoading.dismiss();

        log(jsonEncode(fileResponse));
      },
    );

    updateCardController.cardUpdate.value.cardAttachments
        .insert(0, fileResponse);
    updateCardController.cardUpdate.refresh();
  }
}
